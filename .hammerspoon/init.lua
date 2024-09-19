--- vim:set colorcolumn=100:

local constants = require("constants")
local utils = require("utils")
local layout = require("layout")

--- Disable animations
hs.window.animationDuration = 0

--- Disable notification about spotlight search
hs.application.enableSpotlightForNameSearches(false)

--- Load SpoonInstall to install Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = false
Install = spoon.SpoonInstall

Install:andUse("EmmyLua", {
	--- Re-generating autocomplete is slow, enabled manually when it needs to be regenerated
	disable = true,
})

Install:andUse("ReloadConfiguration", {
	start = true,
})

Install:andUse("RestartBluetooth", {
	disable = not utils.is_work,
	start = true,
})

Install:andUse("GitHubNotifications", {
	--- disable = not utils.is_work,
	disable = true,
	start = true,
	config = {
		token = constants.github_token,
	},
})

Install:andUse("AppLauncher", {
	config = {
		modifiers = constants.keys.layer_key,
	},
	hotkeys = {
		--- Home row
		h = "Finder",
		j = constants.browser,
		k = "kitty",
		l = utils.if_work("Slack", "Telegram"),
		[";"] = utils.if_work(nil, "Mimestream"),
		--- Bottom row
		n = "Todoist",
		m = "Figma",
		["."] = utils.if_work("zoom.us", nil),
		[","] = "ChatGPT",
		["/"] = utils.if_work("Linear", "Google Chrome"),
	},
})

local screens = constants.screens

--- Main layout, browser on right most screen, Figma behind browser, kitty on
--- main screen. Email/Slack on left most screen.
hs.hotkey.bind(constants.keys.layer_key, "u", function()
	layout.apply_layout({
		{ constants.browser, nil, screens.laptop, hs.layout.maximized },
		{ "kitty", nil, screens.laptop, hs.layout.maximized },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ "Zoom", "Zoom", screens.laptop, layout.put_center },
		{ "Mimestream", layout.get_mimestream_window, screens.laptop, hs.layout.maximized },
		{ "Slack", nil, screens.laptop, hs.layout.maximized },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ "Postman", nil, screens.laptop, hs.layout.maximized },
		{ "Linear", nil, screens.laptop, hs.layout.maximized },
	}, {}, {
		--- Laptop
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized },
		--- Primary
		{ constants.browser, nil, screens.primary, hs.layout.maximized },
		{ "kitty", nil, screens.primary, hs.layout.maximized },
		--- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized },
		{ "ChatGPT", nil, screens.secondary, layout.put_left },
		{ "Mimestream", layout.get_mimestream_window, screens.secondary, hs.layout.maximized },
		{ "Slack", nil, screens.secondary, hs.layout.maximized },
		{ "Postman", nil, screens.secondary, hs.layout.maximized },
		{ "Linear", nil, screens.secondary, hs.layout.maximized },
	})
end)

--- Split layout, browser on left of main screen, kitty on right of main screen.
--- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(constants.keys.layer_key, "i", function()
	layout.apply_layout({
		{ constants.browser, nil, screens.laptop, hs.layout.left50 },
		{ "kitty", nil, screens.laptop, hs.layout.right50 },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.left50 },
		{ "Zoom", "Zoom", screens.laptop, layout.put_left },
		{ "Mimestream", layout.get_mimestream_window, screens.laptop, hs.layout.maximized },
		{ "Slack", nil, screens.laptop, hs.layout.maximized },
		{ "Postman", nil, screens.laptop, hs.layout.maximized },
		{ "Linear", nil, screens.laptop, hs.layout.maximized },
	}, {}, {
		--- Laptop
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ "zoom.us", "Zoom", screens.laptop, layout.put_center },
		--- Primary
		{ constants.browser, nil, screens.primary, hs.layout.left50 },
		{ "kitty", nil, screens.primary, hs.layout.right50 },
		--- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized },
		{ "ChatGPT", nil, screens.secondary, layout.put_left },
		{ "Mimestream", layout.get_mimestream_window, screens.secondary, hs.layout.maximized },
		{ "Slack", nil, screens.secondary, hs.layout.maximized },
		{ "Postman", nil, screens.secondary, hs.layout.maximized },
		{ "Linear", nil, screens.secondary, hs.layout.maximized },
	})
end)

--- Zoom layout, browser and kitty on left of main screen, Zoom on the right of
--- main screen. Figma maximized on the right most screen, Email/Slack on left
--- most screen.
hs.hotkey.bind(constants.keys.layer_key, "o", function()
	layout.apply_layout({
		{ constants.browser, nil, screens.laptop, hs.layout.right50 },
		{ "kitty", nil, screens.laptop, hs.layout.right50 },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.left50 },
		{ "Zoom", "Zoom", screens.laptop, layout.put_left },
		{ "Mimestream", layout.get_mimestream_window, screens.laptop, hs.layout.maximized },
		{ "Slack", nil, screens.laptop, hs.layout.maximized },
		{ "Postman", nil, screens.laptop, hs.layout.maximized },
		{ "Linear", nil, screens.laptop, hs.layout.maximized },
	}, {}, {
		--- Primary
		{ constants.browser, nil, screens.primary, hs.layout.right50 },
		{ "kitty", nil, screens.primary, hs.layout.right50 },
		{ "zoom.us", "Zoom Meeting", screens.primary, hs.layout.left50 },
		{ "Zoom", "Zoom", screens.primary, layout.put_left },
		--- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized },
		{ "ChatGPT", nil, screens.secondary, layout.put_left },
		{ "Mimestream", layout.get_mimestream_window, screens.secondary, hs.layout.maximized },
		{ "Slack", nil, screens.secondary, hs.layout.maximized },
		{ "Postman", nil, screens.secondary, hs.layout.maximized },
		{ "Linear", nil, screens.secondary, hs.layout.maximized },
	})
end)

--- Left half
hs.hotkey.bind({ "cmd", "alt" }, "Left", function()
	local win, max = layout.get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x, max.y, max.w / 2, max.h))
end)

--- Right half
hs.hotkey.bind({ "cmd", "alt" }, "Right", function()
	local win, max = layout.get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x + (max.w / 2), max.y, max.w / 2, max.h))
end)

--- Maximize
hs.hotkey.bind({ "cmd", "alt" }, "f", function()
	local win, max = layout.get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x, max.y, max.w, max.h))
end)

-- Move window to the previous display
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "Left", function()
	local win = hs.window.focusedWindow()
	local prevScreen = win:screen():toWest()
	win:moveToScreen(prevScreen)
end)

-- Move window to the next display
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "Right", function()
	local win = hs.window.focusedWindow()
	local nextScreen = win:screen():toEast()
	win:moveToScreen(nextScreen)
end)

--- Escape paste-blocking
hs.hotkey.bind({ "cmd", "alt" }, "v", function()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

--- Audio presets
hs.hotkey.bind({ "cmd", "ctrl" }, "f9", function()
	--- @diagnostic disable-next-line: undefined-field
	hs.audiodevice.defaultOutputDevice():setOutputVolume(30)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "f10", function()
	--- @diagnostic disable-next-line: undefined-field
	hs.audiodevice.defaultOutputDevice():setOutputVolume(50)
end)

--- Manage focus when in Zoom meetings
--- TODO: Re-enable this, but it's horrifically slow to start
if false then
	hs.window.filter.default
		:setAppFilter("zoom.us")
		:subscribe(hs.window.filter.windowCreated, utils.focus("on"))
		:subscribe(hs.window.filter.windowTitleChanged, utils.focus("on"))
		:subscribe(hs.window.filter.windowDestroyed, utils.focus("off"))
end

--- Media management
hs.hotkey.bind({ "option" }, "p", utils.media("playpause"))
hs.hotkey.bind({ "option" }, "n", utils.media("next"))
