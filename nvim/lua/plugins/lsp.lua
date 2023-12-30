return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"mskelton/null-ls.nvim",
		"ray-x/lsp_signature.nvim",
		"onsails/lspkind-nvim",
		--- "creativenull/efmls-configs-nvim",
	},
	config = function()
		return require("lsp").setup()
	end,
}
