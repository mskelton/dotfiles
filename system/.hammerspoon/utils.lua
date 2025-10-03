local M = {}

--- Print a table to the console
function P(...)
	print(hs.inspect.inspect(...))
end

--- Check if a file exists at the given path
--- @param filename string
--- @return boolean
M.file_exists = function(filename)
	local file = io.open(filename, "r")
	if file then
		file:close()
		return true
	end

	return false
end

--- Check if we are at work by looking for a ~/.work file
M.is_work = M.file_exists(os.getenv("HOME") .. "/.work")

--- Returns the first argument if at work, otherwise the second
--- @param work any
--- @param home any
M.if_work = function(work, home)
	if M.is_work then
		return work
	end

	return home
end

--- Set the focus state
--- @param state string
M.set_focus = function(state)
	hs.execute("shortcuts run 'Focus' <<<'" .. state .. "'")
end

--- Returns a function that sets the focus state
--- @param state string
M.focus = function(state)
	return function()
		M.set_focus(state)
	end
end

--- Returns true if a string starts with a given prefix
--- @param str string
--- @param prefix string
--- @returns boolean
M.starts_with = function(str, prefix)
	return string.sub(str, 1, string.len(prefix)) == prefix
end

--- Bind a hotkey
--- @param modifiers table|nil
--- @param key string
--- @param fn function
--- @param options table|nil
function M.bind(modifiers, key, fn, options)
	if options and options.rep then
		hs.hotkey.bind(modifiers, key, fn, nil, fn)
	else
		hs.hotkey.bind(modifiers, key, fn)
	end
end

--- Returns the default output device
--- @return hs.audiodevice
M.output_device = function()
	--- @diagnostic disable-next-line: undefined-field, return-type-mismatch
	return hs.audiodevice.defaultOutputDevice()
end

return M
