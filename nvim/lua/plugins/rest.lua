return {
	"rest-nvim/rest.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	ft = "http",
	config = function()
		local rest = require("rest-nvim")

		rest.setup({})

		vim.keymap.set("n", "<CR>", rest.run)
	end,
}
