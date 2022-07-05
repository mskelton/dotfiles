return function()
	require("nvim-tree").setup({
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		filters = {
			custom = { "\\.git" },
		},
		sync_root_with_cwd = true,
		update_focused_file = {
			enable = true,
		},
	})
end
