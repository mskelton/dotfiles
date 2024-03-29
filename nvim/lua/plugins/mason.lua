return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		require("mason").setup({
			registries = {
				"file:~/dev/dotfiles/nvim/mason-registry",
				"github:mason-org/mason-registry",
			},
			ui = { border = "rounded" },
		})

		require("mason-lspconfig").setup({ automatic_installation = true })
		require("mason-null-ls").setup({
			automatic_installation = { exclude = { "dprint", "rustfmt" } },
		})
	end,
}
