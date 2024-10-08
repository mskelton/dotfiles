local M = {}

--- Normalizes the options for a keymap
--- @param opts_or_desc table|string|nil
--- @return table
M.normalize_map_opts = function(opts_or_desc)
	local opts

	if type(opts_or_desc) == "string" then
		opts = { desc = opts_or_desc, silent = true }
	else
		opts = vim.tbl_extend("keep", opts_or_desc or {}, { silent = true })
	end

	return opts
end

--- Sets a keymap
--- @param mode string|table
--- @param key string
--- @param cmd string|function
--- @param opts_or_desc table|string|nil
M.map = function(mode, key, cmd, opts_or_desc)
	vim.keymap.set(mode, key, cmd, M.normalize_map_opts(opts_or_desc))
end

--- @class Map
--- @field set fun(): Map
--- @field del fun(): Map

--- Creates a keymap function
--- @param mode string|table
--- @param key string
--- @param cmd string|function
--- @param opts_or_desc table|string|nil
--- @return Map
M.map_fn = function(mode, key, cmd, opts_or_desc)
	local Map = {}
	Map.__index = Map

	function Map:new()
		local instance = setmetatable({}, self)
		return instance
	end

	function Map:set()
		vim.keymap.set(mode, key, cmd, M.normalize_map_opts(opts_or_desc))
		return self
	end

	function Map:del()
		vim.keymap.del(mode, key)
		return self
	end

	return Map:new():set()
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
	return string.gsub("-" .. str, "([-_])(%a)", function(_, b)
		return string.upper(b)
	end)
end

--- Safely requires a lua module. Returns a boolean indicating if the module was
--- successfully required and the module itself.
--- @param module string
--- @param callback function|nil
--- @return boolean, any
M.safe_require = function(module, callback)
	local ok, result = pcall(require, module)
	if not ok then
		vim.schedule(function()
			vim.notify(
				string.format("Error requiring: %s", module),
				vim.log.levels.ERROR
			)
		end)
	end

	--- If a callback was provided, then call it with the result
	if ok and callback then
		callback(result)
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
	local url = string.gsub(text, "'", "\\'")
	os.execute("echo '" .. url .. "' | url | xargs open")
end

--- Get's the truncation width for the current window size.
--- @param default number
--- @param spec table
M.get_trunc_width = function(default, spec)
	local current_width = vim.fn.winwidth(0)

	for _, item in pairs(spec) do
		if current_width < item.max then
			return item.width
		end
	end

	return default
end

--- Returns a function that truncates a string to the provided width based on
--- the current window size.
--- @param default number
--- @param spec table
M.trunc = function(default, spec)
	--- @param str string
	return function(str)
		local width = M.get_trunc_width(default, spec)

		return require("plenary.strings").truncate(str, width, nil, 0)
	end
end

--- Returns a function that returns true when the current window width is
--- greater than the provided width.
--- @param width number
M.min_width = function(width)
	return function()
		return vim.fn.winwidth(0) > width
	end
end

--- Run a system command and load the results into a quickfix list
--- @param cmd string[]
M.run_system_to_qfix = function(cmd)
	local args = vim.fn.shellescape(table.concat(cmd, " "))
	vim.cmd(string.format("cexpr system(%s) | copen", args))
end

--- Creates an autocmd group that will automatically group and clear the autocmds
--- created within it.
--- @param name string
--- @param func fun(autocmd: fun(event: any, opts: vim.api.keyset.create_autocmd))
M.augroup = function(name, func)
	local group = vim.api.nvim_create_augroup(name, {})

	--- @param event any
	--- @param opts vim.api.keyset.create_autocmd
	local function autocmd(event, opts)
		vim.api.nvim_create_autocmd(
			event,
			vim.tbl_extend("force", opts, { group = group })
		)
	end

	func(autocmd)
end

return M
