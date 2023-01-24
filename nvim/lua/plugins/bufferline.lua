return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	config = true,
	opts = {
		options = {
			always_show_bufferline = false,
			indicator = { style = "none" },
			separator_style = "thin",
			show_buffer_close_icons = false,
		},
	},
}
