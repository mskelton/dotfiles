return function()
	local util = require("lspconfig.util")
	local tsserver = require("config.lsp.tsserver")

	-- Setup autocmds and null-ls
	require("config.lsp.autocmd")
	require("config.lsp.null-ls")

	-- Better completion for Neovim Lua
	require("lua-dev").setup({})

	-- Custom config per LSP. The order of keys in this table is very important
	-- when it comes to code actions. Code actions will be prioritized bottom
	-- to top in this table.
	local servers = {
		gopls = {},
		sourcekit = {},
		sumneko_lua = {},
		jsonls = {
			settings = {
				json = { schemas = require("config.lsp.json-schemas") },
			},
		},
		stylelint_lsp = {
			root_dir = util.root_pattern(".stylelintrc", ".stylelintrc.js"),
			settings = {
				stylelintplus = {
					autoFixOnFormat = true,
				},
			},
		},
		eslint = {},
		tailwindcss = {
			root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
		},
	}

	-- Install all servers
	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({ automatic_installation = true })

	-- Update the LSP capabilities to support completions and snippets.
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	-- Setup all LSP clients
	for server, config in pairs(servers) do
		config.capabilities = capabilities
		require("lspconfig")[server].setup(config)
	end

	-- Setup TypeScript separately through the plugin
	require("typescript").setup({
		server = {
			init_options = {
				plugins = tsserver.get_plugins(),
			},
			on_init = tsserver.on_init,
			handlers = tsserver.handlers,
			cmd = {
				tsserver.npm_global_bin("typescript-language-server"),
				"--stdio",
			},
		},
	})
end
