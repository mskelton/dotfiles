return function()
	local function working_directory()
		local cwd = vim.fn.getcwd()
		local home = os.getenv("HOME")

		if home then
			return string.gsub(cwd, home, "~")
		end

		return cwd
	end

	require("lualine").setup({
		extensions = { "fugitive", "quickfix" },
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				working_directory,
				{ "branch", icon = "שׂ" },
				"diff",
				"diagnostics",
			},
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
