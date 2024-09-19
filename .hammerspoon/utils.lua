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

--- Get the user home directory
--- @return string
M.home_dir = function()
	return os.getenv("HOME") or ""
end

--- Check if we are at work by looking for a ~/.work file
M.is_work = M.file_exists(M.home_dir() .. "/.work")

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
	return function()
		hs.execute("shortcuts run 'Media' <<<'" .. arg .. "'")
	end
end

--- Execute a shell command asynchronously
--- @param command string
--- @param args string[]
--- @param callback fun()|nil
M.execute_async = function(command, args, callback)
	hs.task.new(command, callback, args):start()
end

--- Get a menu icon from a PNG file
--- @param filename string
--- @return hs.image|nil
M.get_menu_icon = function(filename)
	--- @type hs.image|nil
	local image = hs.image.imageFromPath(M.home_dir() .. "/.hammerspoon/assets/" .. filename)
	if image == nil then
		return nil
	end

	return image:setSize({ w = 20, h = 20 })
end

return M
