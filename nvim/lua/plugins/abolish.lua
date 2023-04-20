return {
	{
		"tpope/vim-abolish",
		cmd = { "Abolish", "Subvert" },
		lazy = false,
		config = function()
			vim.cmd.Abolish("teh", "the")
			vim.cmd.Abolish("deductable", "deductible")
			vim.cmd.Abolish("calender", "calendar")
		end,
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
