return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"mskelton/null-ls.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"ray-x/lsp_signature.nvim",
		"onsails/lspkind-nvim",
	},
	config = function()
		return require("lsp").setup()
	end,
}
