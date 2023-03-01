return {
	"mskelton/nvim-web-devicons",
	dependencies = { "mskelton/termicons.nvim" },
	config = function()
		require("termicons").setup()
	end,
}
