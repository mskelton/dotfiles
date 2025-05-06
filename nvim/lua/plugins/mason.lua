--- @vs-reviewed
return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-null-ls.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		require("mason").setup({
			ui = { border = "rounded" },
		})

		require("mason-lspconfig").setup({ automatic_installation = true })
		require("mason-null-ls").setup({
			automatic_installation = { exclude = { "dprint", "rustfmt" } },
		})

		require("mason-nvim-dap").setup({
			automatic_setup = true,
			ensure_installed = { "delve" },
		})
	end,
}
