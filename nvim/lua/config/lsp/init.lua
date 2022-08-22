return function()
	local lsp_installer = require("nvim-lsp-installer")
	local lspconfig = require("lspconfig")
	local utils = require("core.utils")
	local handlers = require("config.lsp.handlers")
	local null_ls = require("config.lsp.null-ls")

	handlers.setup()
	handlers.enable_format_on_save()
	null_ls.setup()

	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	-- Custom config per LSP
	local servers = {
		eslint = {
			root_dir = lspconfig.util.find_git_ancestor,
			settings = {
				autoFixOnSave = true,
			},
		},
		gopls = {},
		stylelint_lsp = {
			root_dir = lspconfig.util.find_git_ancestor,
			settings = {
				stylelintplus = {
					autoFixOnSave = true,
				},
			},
		},
		sumneko_lua = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT", path = runtime_path },
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		},
		tsserver = {
			handlers = {
				["textDocument/definition"] = function(_, result, ...)
					-- Don't ever suggest results from React types if there is more than 1
					-- result. Unless I'm going to definition for a React type itself, I
					-- don't want to go there.
					if vim.tbl_islist(result) then
						local react_path = "react/index.d.ts"

						for key, value in ipairs(result) do
							-- If React is the first result, keep it as it's likely
							-- intentional to navigate to the React types.
							if key ~= 1 and utils.ends_with(value.uri, react_path) then
								table.remove(result, key)
							end
						end
					end

					-- Defer to the built-in handler after filtering the results
					vim.lsp.handlers["textDocument/definition"](_, result, ...)
				end,
			},
		},
	}

	-- Install all LSPs
	lsp_installer.setup({
		ensure_installed = vim.tbl_keys(servers),
	})

	-- Setup all LSP clients
	for server, config in pairs(servers) do
		config.capabilities = handlers.capabilities
		config.on_attach = handlers.on_attach

		lspconfig[server].setup(config)
	end
end
