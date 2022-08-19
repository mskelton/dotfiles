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
					autoFixOnFormat = true,
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
		lspconfig[server].setup({
			capabilities = handlers.capabilities,
			on_attach = handlers.on_attach,
			unpack(config),
		})
	end
end