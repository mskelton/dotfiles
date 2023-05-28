return {
	"mskelton/flutter.nvim",
	dependencies = { "neovim/nvim-lspconfig" },
	ft = { "dart" },
	config = function()
		require("flutter").setup({
			lsp = {
				capabilities = function(capabilities)
					require("cmp_nvim_lsp").default_capabilities(capabilities)
				end,
			},
		})
	end,
}
