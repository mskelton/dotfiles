return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
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
	end,
}
