return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"jose-elias-alvarez/null-ls.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"ray-x/lsp_signature.nvim",
		"onsails/lspkind-nvim",
	},
	config = function()
		return require("lsp").setup()
	end,
}
