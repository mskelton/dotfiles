return function()
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
					-- Filter out certain paths from the results that are 99% of the time
					-- false positive results for my use case. If I explicitly jump to
					-- them, go there, otherwise ignore them.
					if vim.tbl_islist(result) then
						local ignored_paths = {
							"react/index.d.ts",
							"patterns-core/src/types/polymorphic.ts",
						}

						for key, value in ipairs(result) do
							for _, path in pairs(ignored_paths) do
								-- If an ignored path is the first result, keep it as it's
								-- likely the intended path.
								if key ~= 1 and utils.ends_with(value.uri, path) then
									table.remove(result, key)
								end
							end
						end
					end

					-- Defer to the built-in handler after filtering the results
					vim.lsp.handlers["textDocument/definition"](_, result, ...)
				end,
			},
		},
	}

	-- Install all servers
	require("mason").setup()
	require("mason-lspconfig").setup({ automatic_installation = true })

	-- Setup all LSP clients
	for server, config in pairs(servers) do
		config.capabilities = handlers.capabilities
		config.on_attach = handlers.on_attach

		lspconfig[server].setup(config)
	end
end
