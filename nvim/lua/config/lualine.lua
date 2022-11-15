return function()
	local colors = require("tokyonight.colors").setup()

	require("lualine").setup({
		options = {
			component_separators = "",
			section_separators = "",
			globalstatus = true,
			theme = "tokyonight",
			disabled_filetypes = {
				statusline = { "help" },
			},
		},
		sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {
				{
					function()
						return ""
					end,
					color = function()
						local mode_color = {
							n = colors.red,
							i = colors.green,
							v = colors.blue,
							[""] = colors.blue,
							V = colors.blue,
							c = colors.magenta,
							no = colors.red,
							s = colors.orange,
							S = colors.orange,
							[""] = colors.orange,
							ic = colors.yellow,
							R = colors.purple,
							Rv = colors.purple,
							cv = colors.red,
							ce = colors.red,
							r = colors.cyan,
							rm = colors.cyan,
							["r?"] = colors.cyan,
							["!"] = colors.red,
							t = colors.red,
						}

						return { fg = mode_color[vim.fn.mode()] }
					end,
					padding = { left = 2, right = 1 },
				},
				{
					"filename",
					cond = function()
						return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
					end,
					color = { fg = colors.magenta, gui = "bold" },
				},
				{ "location" },
				{ "progress", color = { fg = colors.fg, gui = "bold" } },
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " " },
					diagnostics_color = {
						color_error = { fg = colors.red },
						color_warn = { fg = colors.yellow },
						color_info = { fg = colors.cyan },
					},
				},
			},
			lualine_x = {
				{
					"diff",
					diff_color = {
						added = { fg = colors.green },
						modified = { fg = colors.orange },
						removed = { fg = colors.red },
					},
					cond = function()
						return vim.fn.winwidth(0) > 80
					end,
				},
				{
					"branch",
					icon = "",
					color = { fg = colors.magenta, gui = "bold" },
					padding = 1,
				},
				{
					function()
						local cwd = vim.fn.getcwd()
						local home = os.getenv("HOME")

						if home then
							return string.gsub(cwd, home, "~")
						end

						return cwd
					end,
					color = { fg = colors.blue },
				},
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	})
end
