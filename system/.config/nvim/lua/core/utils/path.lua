local M = {}

M.join = function(...)
	local args = { ... }
	if #args == 0 then
		return ""
	end

	return table.concat(args, "/")
end

return M
