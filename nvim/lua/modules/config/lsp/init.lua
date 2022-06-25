return function()
	require("modules.config.lsp.handlers").setup()
	require("modules.config.lsp.handlers").enable_format_on_save()
	require("modules.config.lsp.null-ls").setup()

	-- Custom config per LSP
	local servers = { "eslint", "gopls", "stylelint_lsp", "tsserver" }
	local servers_config = {}

	-- Install all LSPs
	local lsp_installer = require("nvim-lsp-installer")
	for _, name in pairs(servers) do
		local server_is_found, server = lsp_installer.get_server(name)

		if server_is_found and not server:is_installed() then
			server:install()
		end
	end

	lsp_installer.on_server_ready(function(server)
		local config = servers_config[server.name] or {}
		config.capabilities = require("modules.config.lsp.handlers").capabilities
		config.on_attach = require("modules.config.lsp.handlers").on_attach
		server:setup(config)
	end)
end
