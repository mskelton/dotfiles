local M = {}

--- Sets a keymap
--- @param mode string
--- @param key string
--- @param cmd string|function
--- @param opts_or_desc table|string
M.map = function(mode, key, cmd, opts_or_desc)
	local opts

	if type(opts_or_desc) == "string" then
		opts = { desc = opts_or_desc, silent = true }
	else
		opts = vim.tbl_extend("keep", opts_or_desc or {}, { silent = true })
	end

	vim.keymap.set(mode, key, cmd, opts)
end

--- Capitalizes a string
--- @param str string
M.capitalize = function(str)
	return str:gsub("^%l", string.upper)
end

--- Returns true when the provided string ends with the provided ending
--- @param str string
--- @param ending string
M.ends_with = function(str, ending)
	return ending == "" or string.sub(str, -#ending) == ending
end

--- Converts a string to camel case
--- @param str string
M.camel_case = function(str)
	return string.gsub("-" .. str, "(%-)(%a)", function(_, b)
		return string.upper(b)
	end)
end

--- Safely requires a lua module. Returns a boolean indicating if the module was
--- successfully required and the module itself.
--- @param module string
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

--- Returns the user's home directory
M.home_dir = function()
	return os.getenv("HOME")
end

--- Converts any value to a boolean
--- @param value any
M.to_bool = function(value)
	if value then
		return true
	end

	return false
end

--- Opens any URLs in the provided text string
--- @param text string
M.open_url = function(text)
	local url = string.gsub(text, '"', '\\"')
	os.execute('echo "' .. url .. '" | url | xargs open')
end

return M
