local utils = require("utils")

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
	self.server:setCallback(function(method, path, _, body)
		if method ~= "POST" then
			return "Only POST is supported\n", 400, {}
		end

		local handlers = {
			["/play"] = hs.fnutils.partial(utils.media, "play"),
			["/pause"] = hs.fnutils.partial(utils.media, "pause"),
			["/toggle"] = hs.fnutils.partial(utils.media, "toggle"),
			["/previous"] = hs.fnutils.partial(utils.media, "previous"),
			["/next"] = hs.fnutils.partial(utils.media, "next"),
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
				handler(hs.json.decode(body))
				return "{}", 200, {}
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

return M
