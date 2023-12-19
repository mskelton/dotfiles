local M = {}

--- Check if a file exists at the given path
--- @param filename string
M.file_exists = function(filename)
	local file = io.open(filename, "r")
	if file then
		file:close()
		return true
	end
end

--- Check if we are at work by looking for a ~/.work file
M.is_work = function()
	return M.file_exists(os.getenv("HOME") .. "/.work")
end

return M
