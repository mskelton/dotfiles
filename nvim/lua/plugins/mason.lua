return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local index = require("mason-registry.index")

		-- Registry overrides
		index["emmet-ls"] = "mason-registry.emmet-ls"
		index["typescript-styled-plugin"] = "mason-registry.ts-styled-plugin"

		require("mason").setup({ ui = { border = "rounded" } })
		require("mason-lspconfig").setup({ automatic_installation = true })
		require("mason-null-ls").setup({ automatic_installation = true })
	end,
}
