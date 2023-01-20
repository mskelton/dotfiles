return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"jose-elias-alvarez/null-ls.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"ray-x/lsp_signature.nvim",
		"onsails/lspkind-nvim",
	},
	config = function()
		return require("lsp")()
	end,
}
