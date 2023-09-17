return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>ho",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			mode = { "n", "v" },
			desc = "Open Harpoon menu",
		},
		{
			"<leader>ha",
			function()
				require("harpoon.mark").add_file()
			end,
			mode = { "n", "v" },
			desc = "Add file to Harpoon",
		},
		{
			"]h",
			function()
				require("harpoon.ui").nav_next()
			end,
			mode = "n",
			desc = "Next harpoon mark",
		},
		{
			"[h",
			function()
				require("harpoon.ui").nav_prev()
			end,
			mode = "n",
			desc = "Previous harpoon mark",
		},
	},
	config = {
		mark_branch = true,
	},
}
