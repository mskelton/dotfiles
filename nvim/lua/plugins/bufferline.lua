return {
	"akinsho/bufferline.nvim",
	event = "BufReadPre",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	config = true,
	opts = {
		options = {
			indicator = { style = "none" },
			separator_style = "thin",
			show_buffer_close_icons = false,
		},
	},
}
