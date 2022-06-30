return function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	local fortune = require("alpha.fortune")

	-- Inspired by https://github.com/glepnir/dashboard-nvim with my own flair
	local header = {
		[[                                                                   ]],
		[[      ████ ██████           █████      ██                    ]],
		[[     ███████████             █████                            ]],
		[[     █████████ ███████████████████ ███   ███████████  ]],
		[[    █████████  ███    █████████████ █████ ██████████████  ]],
		[[   █████████ ██████████ █████████ █████ █████ ████ █████  ]],
		[[ ███████████ ███    ███ █████████ █████ █████ ████ █████ ]],
		[[██████  █████████████████████ ████ █████ █████ ████ ██████]],
	}

	-- Make the header a bit more fun with some color!
	local function colorize_header()
		local lines = {}

		for i, chars in pairs(header) do
			local line = {
				type = "text",
				val = chars,
				opts = {
					hl = "StartLogo" .. i,
					shrink_margin = false,
					position = "center",
				},
			}

			table.insert(lines, line)
		end

		return lines
	end

	dashboard.section.buttons.val = {
		dashboard.button("e", "  New file", ":ene | startinsert <CR>"),
		dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
		dashboard.button("g", "  Find word", ":Telescope live_grep<CR>"),
		dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	}

	-- Everyone could use a good fortune cookie from time to time, right?
	dashboard.section.footer.val = fortune()

	-- Hide the tab bar
	vim.cmd([[au User AlphaReady set showtabline=0 | au BufUnload <buffer> set showtabline=2]])

	alpha.setup({
		layout = {
			{ type = "padding", val = 4 },
			{ type = "group", val = colorize_header() },
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			dashboard.section.footer,
		},
		opts = { margin = 5 },
	})
end
