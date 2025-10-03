local M = {}

--- Metadata
M.name = "Remote"
M.version = "1.0"
M.author = "Mark Skelton <mark@mskelton.dev>"
M.homepage = "https://github.com/mskelton/dotfiles"
M.license = "ISC - https://opensource.org/licenses/ISC"

function M:start()
	--- @type hs.httpserver|nil
	self.server = hs.httpserver.new()
	self.server:setPort(self.port)
	self.server:setCallback(function(method, path, _, request_body)
		if method ~= "POST" then
			return "Only POST is supported\n", 400, {}
		end


		local handlers = {
			["/toggle"] = function()
				hs.eventtap.event.newSystemKeyEvent("PLAY", true):post()
			end,
			["/rewind"] = function()
				hs.execute("shortcuts run 'Rewind'")
			end,
			["/fast-forward"] = function()
				hs.execute("shortcuts run 'Fast Forward'")
			end,
			["/volume"] = function(req)
				--- @type hs.audiodevice|nil
				local device = hs.audiodevice.defaultOutputDevice()
				if not device then
					return
				end

				if req.action == "SET" then
					device:setOutputVolume(req.value)
				elseif req.action == "INCREMENT" then
					--- @diagnostic disable-next-line: undefined-field
					--- @type number|nil
					local volume = device:outputVolume()
					if volume == nil then
						return
					end

					device:setOutputVolume(math.max(0, math.min(100, volume + req.value)))
				else
					return "Bad request\n", 400, {}
				end
			end,
			["/mute"] = function()
				--- @type hs.audiodevice|nil
				local device = hs.audiodevice.defaultOutputDevice()
				if not device then
					return
				end

				device:setOutputMuted(not device:outputMuted())
			end,
		}

		for key, handler in pairs(handlers) do
			if path == key then
				--- Decode the request data
				local post_data = nil
				if request_body ~= "" then
					post_data = hs.json.decode(request_body)
				end

				--- Run the handler
				local response_body, status, response_headers = handler(post_data)
				if response_body ~= nil then
					return response_body, status, response_headers
				else
					return hs.json.encode(self:get_state()), 200, {}
				end
			end
		end

		return "Not found\n", 404, {}
	end)

	self.server:start()

	return self
end

function M:stop()
	if self.server then
		self.server:stop()
	end

	return self
end

function M:get_state()
	--- @type hs.audiodevice|nil
	local device = hs.audiodevice.defaultOutputDevice()
	if not device then
		return
	end

	return {
		is_playing = M:is_playing(),
		is_muted = device:outputMuted(),
		volume = device:outputVolume(),
	}
end

function M:is_playing()
	local handle = io.popen("pmset -g")
	if handle == nil then
		return false
	end

	local result = handle:read("*a")
	handle:close()

	return result:find("display sleep prevented by") ~= nil
end

return M
