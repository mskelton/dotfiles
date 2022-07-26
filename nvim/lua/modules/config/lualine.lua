return function()
	require("lualine").setup({
		tabline = {
			lualine_a = { "buffers" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = { "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		options = {
			section_separators = { left = "", right = "" },
			component_separators = "|",
			globalstatus = true,
			theme = "tokyonight",
		},
	})
end
