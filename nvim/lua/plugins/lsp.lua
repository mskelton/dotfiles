return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"ray-x/lsp_signature.nvim",
		"onsails/lspkind-nvim",
		"creativenull/efmls-configs-nvim",
	},
	config = function()
		return require("lsp").setup()
	end,
}
