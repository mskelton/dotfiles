return function()
	local lsp_installer = require("nvim-lsp-installer")
	local lspconfig = require("lspconfig")
	local handlers = require("config.lsp.handlers")
	local null_ls = require("config.lsp.null-ls")

	handlers.setup()
	handlers.enable_format_on_save()
	null_ls.setup()

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
					runtime = { version = "LuaJIT" },
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
					},
				},
			},
		},
		tsserver = {},
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
