local M = {}

M.capitalize = function(str)
	return (str:gsub("^%l", string.upper))
end

M.camel_case = function(str)
	return string.gsub("-" .. str, "(%-)(%l)", function(_, b)
		return string.upper(b)
	end)
end

return M
