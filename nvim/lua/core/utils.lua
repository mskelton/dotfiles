local M = {}

M.map = function(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

M.capitalize = function(str)
	return str:gsub("^%l", string.upper)
end

M.ends_with = function(str, ending)
	return ending == "" or str:sub(-#ending) == ending
end

M.camel_case = function(str)
	return string.gsub("-" .. str, "(%-)(%a)", function(_, b)
		return string.upper(b)
	end)
end

M.safe_require = function(module)
	local ok, result = pcall(require, module)
	if not ok then
		vim.schedule(function()
			vim.notify(
				string.format("Error requiring: %s", module),
				vim.log.levels.ERROR
			)
		end)
	end

	return ok, result
end

return M
