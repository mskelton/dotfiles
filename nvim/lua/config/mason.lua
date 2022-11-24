return function()
	local index = require("mason-registry.index")

	-- Use custom Emmet package which is setup only for CSS
	index["emmet-ls"] = "config.mason-registry.emmet-ls"

	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({ automatic_installation = true })
	require("mason-null-ls").setup({ automatic_installation = true })
end
