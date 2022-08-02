return function()
	require("lualine").setup({
		tabline = {
			lualine_a = {
				{
					"buffers",
					symbols = {
						alternate_file = "",
					},
				},
			},
		},
		extensions = { "fugitive", "quickfix" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		options = {
			globalstatus = true,
			theme = "tokyonight",
		},
	})
end
