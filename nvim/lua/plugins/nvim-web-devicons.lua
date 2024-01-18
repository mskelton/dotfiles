return {
	"nvim-tree/nvim-web-devicons",
	dependencies = {
		{
			"mskelton/termicons.nvim",
			dev = false,
		},
	},
	config = function()
		require("termicons").setup()
	end,
}
