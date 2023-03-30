return {
	{
		"tpope/vim-abolish",
		event = "CmdLineEnter",
	},
	{
		"markonm/traces.vim",
		event = "VeryLazy",
		enabled = false,
		init = function()
			vim.g.traces_substitute_preview = 1
			vim.g.traces_abolish_integration = 1
			vim.api.nvim_set_hl(0, "TracesSearch", { link = "IncSearch" })
		end,
	},
}
