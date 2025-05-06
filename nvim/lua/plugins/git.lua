--- @vs-reviewed
local function default_branch()
	return string.gsub(vim.fn.execute("Git default"), "\n", "")
end

local function filename()
	return vim.fn.expand("%:p")
end

function CopyGitRemoteURLFromSelection()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local cmd = string.format(
		"%s,%sGBrowse! %s:%s",
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
				"<leader>vw",
				function()
					vim.cmd(string.format("GBrowse! %s:%s", default_branch(), filename()))
				end,
				mode = "n",
				desc = "Copy remote URL",
			},
			{
				"<leader>vw",
				":lua CopyGitRemoteURLFromSelection()<cr>",
				mode = "v",
				desc = "Copy remote URL for selection",
			},
			{
				"<leader>vL",
				"<cmd>Git checkout -<cr>",
				mode = { "n", "v" },
				desc = "Checkout last branch",
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
		"kdheepak/lazygit.nvim",
		keys = {
			{
				"<leader>lg",
				"<cmd>LazyGit<cr>",
				mode = { "n", "v" },
				desc = "Open LazyGit",
			},
		},
	},
}
