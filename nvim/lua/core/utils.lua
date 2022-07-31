local M = {}

M.map = function(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

M.capitalize = function(str)
	return (str:gsub("^%l", string.upper))
end

M.camel_case = function(str)
	return string.gsub("-" .. str, "(%-)(%a)", function(_, b)
		return string.upper(b)
	end)
end

return M
