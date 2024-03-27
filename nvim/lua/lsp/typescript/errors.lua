local M = {}

--- Throw an error
--- @param err string
M.reject = function(err)
	vim.schedule(function()
		vim.notify("[vtsls]: " .. tostring(err), vim.log.levels.ERROR)
	end)
end

return M
