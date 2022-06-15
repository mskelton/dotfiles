return function()
	require("nvim-tree").setup({
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		update_focused_file = {
			enable = true,
		},
		filters = {
			custom = { ".git" },
		},
	})
end
