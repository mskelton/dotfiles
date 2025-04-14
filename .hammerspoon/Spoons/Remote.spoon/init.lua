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
	self.server:setCallback(function(method, path)
		if method ~= "GET" then
			return "Only GET is supported", 400, {}
		end

		--- Play, pause, toggle
		if path == "/play" then
			utils.media("play")
		elseif path == "/pause" then
			utils.media("pause")
		elseif path == "/toggle" then
			utils.media("toggle")
		end

		--- Next, previous
		if path == "/next" then
			utils.media("next")
		elseif path == "/previous" then
			utils.media("previous")
		end

		--- Volume up, down
		if path == "/volumeup" then
			utils.volume(5)
		elseif path == "/volumedown" then
			utils.volume(-5)
		end

		return "OK", 200, {
			["Cache-Control"] = "no-cache",
		}
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
