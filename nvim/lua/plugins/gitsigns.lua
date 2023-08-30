local nv = { "n", "v" }

return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
	config = true,
	keys = {
		{
			"<leader>vs",
			":Gitsigns stage_hunk<cr>",
			silent = true,
			mode = nv,
			desc = "Git: stage hunk",
		},
		{
			"<leader>vu",
			":Gitsigns reset_hunk<cr>",
			silent = true,
			mode = nv,
			desc = "Git: unstage hunk",
		},
		{
			"[v",
			"<cmd>Gitsigns prev_hunk<cr>",
			silent = true,
			mode = nv,
			desc = "Git: previous hunk",
		},
		{
			"]v",
			"<cmd>Gitsigns next_hunk<cr>",
			silent = true,
			mode = nv,
			desc = "Git: next hunk",
		},
	},
}
