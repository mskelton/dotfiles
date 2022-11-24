return function()
	local index = require("mason-registry.index")
	local server = require("mason-lspconfig.mappings.server")

	-- Registry overrides
	index["emmet-ls"] = "config.mason-registry.emmet-ls"
	index["typescript-styled-plugin"] = "config.mason-registry.ts-styled-plugin"

	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({ automatic_installation = true })
	require("mason-null-ls").setup({ automatic_installation = true })
end
