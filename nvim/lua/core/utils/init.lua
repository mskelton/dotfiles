local M = {}

M.map = function(mode, key, cmd, opts_or_desc)
	local opts

	if type(opts_or_desc) == "string" then
		opts = { desc = opts_or_desc, silent = true }
	else
		opts = vim.tbl_extend("keep", opts_or_desc or {}, { silent = true })
	end

	vim.keymap.set(mode, key, cmd, opts)
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

M.home_dir = function()
	return os.getenv("HOME")
end

M.to_bool = function(value)
	if value then
		return true
	end

	return false
end

return M
