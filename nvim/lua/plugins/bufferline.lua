return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = true,
	opts = {
		options = {
			indicator = { style = "none" },
			separator_style = "thin",
			show_buffer_close_icons = false,
			name_formatter = function(args)
				if args.name == "[No Name]" then
					return "Untitled"
				end

				return args.name
			end,
		},
	},
}
