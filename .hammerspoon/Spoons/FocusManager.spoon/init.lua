local M = {}

--- Metadata
M.name = "FocusManager"
M.version = "1.0"
M.author = "Mark Skelton <mark@mskelton.dev>"
M.homepage = "https://github.com/mskelton/dotfiles"
M.license = "ISC - https://opensource.org/licenses/ISC"

function M:start()
	--- @type hs.ipc|nil
	self.ipc = hs.ipc.localPort("focus", function(_, _, data)
		if data:sub(1, 1) == "x" then
			hs.application.launchOrFocus(data:sub(2))
		end
	end)

	return self
end

function M:stop()
	if self.ipc then
		self.ipc:delete()
	end

	return self
end

return M
