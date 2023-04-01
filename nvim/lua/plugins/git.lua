return {
	{
		"tpope/vim-fugitive",
		dependencies = { "tpope/vim-rhubarb" },
		cmd = {
			"G",
			"GBrowse",
			"GDelete",
			"GMove",
			"GRename",
			"Gdiffsplit",
			"Gedit",
			"Ggrep",
			"Git",
			"Gread",
			"Gsplit",
			"Gvdiffsplit",
			"Gwrite",
		},
		keys = {
			{
				"<leader>vb",
				"<cmd>Git blame<cr>",
				mode = { "n", "v" },
				desc = "Git blame",
			},
			{
				"<leader>vd",
				"<cmd>Gvdiffsplit<cr>",
				mode = { "n", "v" },
				desc = "Git diff",
			},
			{
				"<leader>vl",
				"<cmd>vertical Git log<cr>",
				mode = { "n", "v" },
				desc = "Git log",
			},
			{
				"<leader>vp",
				"<cmd>Git push<cr>",
				mode = { "n", "v" },
				desc = "Git push",
			},
			{
				"<leader>vP",
				"<cmd>Git pull<cr>",
				mode = { "n", "v" },
				desc = "Git pull",
			},
		},
	},
	{
		"mskelton/bandit.nvim",
		keys = {
			{
				"<leader>vc",
				function()
					require("bandit").commit()
				end,
				mode = { "n", "v" },
				desc = "Commit changes",
			},
		},
	},
	{
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
	},
}
