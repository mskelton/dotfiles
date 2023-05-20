return {
	-- "akinsho/bufferline.nvim",
	dir = "~/dev/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = true,
	opts = {
		options = {
			indicator = { style = "none" },
			separator_style = "thin",
			show_buffer_close_icons = false,
			always_show_bufferline = false,
		},
	},
}
