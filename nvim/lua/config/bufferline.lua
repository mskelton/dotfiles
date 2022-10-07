return function()
	require("bufferline").setup({
		options = {
			indicator = { style = "none" },
			separator_style = "slant",
			show_buffer_close_icons = false,
		},
	})
end
