return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = true,
	keys = {
		{
			"<leader>vs",
			":Gitsigns stage_hunk<cr>",
			silent = true,
			mode = "v",
			desc = "Git: stage hunk",
		},
		{
			"<leader>vu",
			":Gitsigns reset_hunk<cr>",
			silent = true,
			mode = "v",
			desc = "Git: reset hunk",
		},
	},
}
