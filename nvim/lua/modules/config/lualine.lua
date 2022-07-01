return function()
	require("lualine").setup({
		tabline = {
			lualine_a = { "buffers" },
		},
		options = {
			globalstatus = true,
		},
	})
end
