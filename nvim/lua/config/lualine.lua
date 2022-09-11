return function()
	require("lualine").setup({
		tabline = {
			lualine_a = {
				"buffers",
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

	local group = vim.api.nvim_create_augroup("LualineRefreshOnWrite", {})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = "*",
		callback = function()
			require("lualine").refresh({
				scope = "tabpage",
				place = { "tabline" },
			})
		end,
	})
end
