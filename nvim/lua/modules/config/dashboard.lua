return function()
	local home = os.getenv("HOME")
	local db = require("dashboard")

	db.preview_command = "cat | lolcat -F 0.3"
	db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
	db.preview_file_height = 10
	db.preview_file_width = 70

	db.custom_center = {
		{
			icon = "  ",
			desc = "Re-open last session                    ",
			shortcut = "SPC sl",
			action = "SessionLoad",
		},
		{
			icon = "  ",
			desc = "Recently opened files                   ",
			action = "DashboardFindHistory",
			shortcut = "SPC fh",
		},
		{
			icon = "  ",
			desc = "Find file                               ",
			action = "Telescope find_files",
			shortcut = "SPC p ",
		},
		{
			icon = "  ",
			desc = "Find word                               ",
			action = "Telescope live_grep",
			shortcut = "SPC fg",
		},
		{
			icon = "  ",
			desc = "Open Personal dotfiles                  ",
			action = "Telescope dotfiles path=" .. home .. "/dev/dotfiles",
			shortcut = "SPC fd",
		},
	}
end
