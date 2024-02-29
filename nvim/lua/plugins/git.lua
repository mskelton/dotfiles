local function default_branch()
	return string.gsub(vim.fn.execute("Git default"), "\n", "")
end

local function filename()
	return vim.fn.expand("%:p")
end

function OpenOnGitHubFromSelection()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local cmd = string.format(
		"%s,%sGBrowse %s:%s",
		start_pos[2],
		end_pos[2],
		default_branch(),
		filename()
	)

	vim.cmd(cmd)
end

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
				"<leader>vh",
				"<cmd>Git blame<cr>",
				mode = { "n", "v" },
				desc = "Git history (blame)",
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
			{
				"<leader>vo",
				function()
					vim.cmd(string.format("GBrowse %s:%s", default_branch(), filename()))
				end,
				mode = "n",
				desc = "Open on GitHub",
			},
			{
				"<leader>vo",
				":lua OpenOnGitHubFromSelection()<cr>",
				mode = "v",
				desc = "Open on GitHub",
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
}
