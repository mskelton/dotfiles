return function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	math.randomseed(os.time())

	dashboard.section.header.opts.hl = "AlphaColor" .. math.random(7)
	dashboard.section.header.val = {
		[[                               __                ]],
		[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}

	-- dashboard.section.header.opts.hl = {
	-- 	{ "AlphaColor1", 0, -1 },
	-- 	{ "AlphaColor2", 0, -1 },
	-- 	{ "AlphaColor3", 0, -1 },
	-- 	{ "AlphaColor3", 0, -1 },
	-- }

	-- dashboard.section.buttons.val = {
	-- 	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	-- 	dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
	-- }

	-- Everyone could use a good fortune cookie from time to time, right?
	local handle = io.popen("fortune -s")
	local fortune = handle:read("*a")
	handle:close()
	dashboard.section.footer.val = fortune

	-- Hide the tab bar
	vim.cmd([[au User AlphaReady set showtabline=0 | au BufUnload <buffer> set showtabline=2]])

	alpha.setup(dashboard.config)
end
