local utils = require("core.utils")
local path = require("core.utils.path")

local M = {}

-- Returns the location where global npm packages are installed.
M.npm_global_path = function()
	return path.join(utils.home_dir(), ".local/share/npm")
end

-- Returns the location of a global npm binary. This can be used to set the cmd
-- of an lsp server to a globally linked package.
M.npm_global_bin = function(pkg)
	return path.join(M.npm_global_path(), "bin", pkg)
end

-- Returns the location of a global npm plugin. This is used to instruct
-- tsserver of plugin locations so they can be properly loaded.
M.npm_global_lib = function(pkg)
	return path.join(M.npm_global_path(), "lib", pkg)
end

-- Global plugins to be loaded when starting tsserver
M.plugins = {
	{
		name = "typescript-styled-plugin",
		location = M.npm_global_lib("typescript-styled-plugin"),
		config = {
			validate = false,
			-- TODO: Once a real Emmet server is installed, uncomment this
			-- emmet = { showExpandedAbbreviation = "never" },
		},
	},
}

-- Get's the list of global plugins to load
M.get_plugins = function()
	return vim.tbl_map(function(item)
		return { name = item.name, location = item.location }
	end, M.plugins)
end

-- Configure global plugins when tsserver initializes
M.on_init = function(client)
	for _, value in ipairs(M.plugins) do
		-- If the plugin does not contain any custom config, we don't need to send
		-- the configuration request.
		if value.config ~= nil then
			local params = {
				command = "_typescript.configurePlugin",
				arguments = { value.name, value.config },
			}

			client.request("workspace/executeCommand", params)
		end
	end
end

-- Custom handlers for TypeScript LSP actions
M.handlers = {
	["textDocument/definition"] = function(_, result, ...)
		-- Filter out certain paths from the results that are 99% of the time
		-- false positive results for my use case. If I explicitly jump to
		-- them, go there, otherwise ignore them.
		if vim.tbl_islist(result) then
			local ignored_paths = {
				"react/index.d.ts",
				"patterns-core/src/types/polymorphic.ts",
			}

			for key, value in ipairs(result) do
				for _, ignored_path in pairs(ignored_paths) do
					-- If an ignored path is the first result, keep it as it's
					-- likely the intended path.
					if key ~= 1 and utils.ends_with(value.targetUri, ignored_path) then
						table.remove(result, key)
					end
				end
			end
		end

		-- Defer to the built-in handler after filtering the results
		vim.lsp.handlers["textDocument/definition"](_, result, ...)
	end,
}

return M
