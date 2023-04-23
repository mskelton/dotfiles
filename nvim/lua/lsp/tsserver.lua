local utils = require("core.utils")
local npm = require("utils.npm")

local M = {}

-- Global plugins to be loaded when starting tsserver
M.plugins = {
	{
		name = "typescript-styled-plugin",
		location = npm.mason_lib("typescript-styled-plugin"),
		config = {
			validate = false,
			emmet = { showExpandedAbbreviation = "never" },
		},
	},
}

-- Get's the list of global plugins to load
M.get_plugins = function()
	return vim.tbl_map(function(item)
		return { name = item.name, location = item.location }
	end, M.plugins)
end

M.get_tsserver_options = function(opts)
	opts = opts or {}

	-- If Neovim is started with `TSSERVER_LOG=1`, then we enable verbose logging.
	if os.getenv("TSSERVER_LOG") == "1" then
		opts.logDirectory = "/tmp/tsserver-logs"
		opts.logVerbosity = "verbose"
	end

	return opts
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
	-- Filter out certain paths from the results that are 99% of the time
	-- false positive results for my use case. If I explicitly jump to
	-- them, go there, otherwise ignore them.
	["textDocument/definition"] = function(_, result, ...)
		if vim.tbl_islist(result) then
			local ignored_paths = {
				"react/index.d.ts",
				"react/ts5.0/index.d.ts",
				"tailwind-variants/dist/index.d.ts",
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
