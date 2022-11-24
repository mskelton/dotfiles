local utils = require("core.utils")
local path = require("core.utils.path")

local M = {}

-- Returns the location where global npm packages are installed.
M.global_path = function()
	return path.join(utils.home_dir(), ".local/share/npm")
end

-- Returns the location of a global npm binary. This can be used to set the cmd
-- of an lsp server to a globally linked package.
M.global_bin = function(pkg)
	return path.join(M.global_path(), "bin", pkg)
end

-- Returns the location of a global npm plugin. This is used to instruct
-- tsserver of plugin locations so they can be properly loaded.
M.global_lib = function(pkg)
	return path.join(M.global_path(), "lib", pkg)
end

return M
