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

--- Music management
--- @param arg string
M.media = function(arg)
	hs.execute("shortcuts run 'Media' <<<'" .. arg .. "'")
end

return M
