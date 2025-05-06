--- @vs-reviewed
return {
	"akinsho/toggleterm.nvim",
	keys = {
		{
			"<C-\\>",
			'<Cmd>execute v:count . "ToggleTerm"<CR>',
			mode = { "n", "v" },
			desc = "Toggle Terminal",
		},
		{
			"<C-\\>",
			'<Cmd>execute v:count . "ToggleTerm"<CR>',
			mode = "i",
			desc = "Toggle Terminal",
		},
	},
	opts = {
		autochdir = true,
		direction = "float",
		on_open = function(term)
			vim.keymap.set(
				"t",
				"<C-\\>",
				"<Cmd>ToggleTerm<CR>",
				{ buffer = term.bufnr }
			)
		end,
		shade_terminals = false,
		float_opts = {
			border = "rounded",
		},
	},
}
