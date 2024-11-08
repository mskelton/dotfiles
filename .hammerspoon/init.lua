--- vim:set colorcolumn=100:

local apps = require("apps")
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
	disable = not utils.is_work,
	start = true,
	hotkeys = {
		open = { constants.keys.layer_key, "p" },
	},
})

Install:andUse("AppLauncher", {
	config = {
		modifiers = constants.keys.layer_key,
	},
	hotkeys = {
		--- Home row
		h = apps.finder,
		j = apps.categories.browser,
		k = apps.categories.terminal,
		l = apps.categories.messaging,
		[";"] = apps.categories.email,
		--- Bottom row
		m = apps.categories.tasks,
		[","] = apps.chat_gpt,
		["."] = utils.if_work(apps.figma, nil),
		["/"] = utils.if_work(apps.zoom, nil),
	},
})

local screens = constants.screens

--- Main layout, browser on right most screen, Figma behind browser, kitty on
--- main screen. Email/Slack on left most screen.
hs.hotkey.bind(constants.keys.layer_key, "u", function()
	layout.apply_layout({
		{ apps.categories.browser, nil, screens.laptop, hs.layout.maximized },
		{ apps.categories.terminal, nil, screens.laptop, hs.layout.maximized },
		{ apps.mimestream, layout.mimestream_inbox, screens.laptop, hs.layout.maximized },
		{ apps.slack, nil, screens.laptop, hs.layout.maximized },
		{ apps.linear, nil, screens.laptop, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.laptop, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.laptop, layout.put_center },
	}, {
		{ apps.categories.browser, nil, screens.primary, hs.layout.maximized },
		{ apps.categories.terminal, nil, screens.primary, hs.layout.maximized },
		{ apps.mimestream, layout.mimestream_inbox, screens.primary, hs.layout.maximized },
		{ apps.slack, nil, screens.primary, hs.layout.maximized },
		{ apps.linear, nil, screens.primary, hs.layout.maximized },
		{ apps.figma, nil, screens.primary, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.primary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.primary, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
	}, {
		{ apps.categories.browser, nil, screens.primary, hs.layout.maximized },
		{ apps.categories.terminal, nil, screens.primary, hs.layout.maximized },
		{ apps.mimestream, layout.mimestream_inbox, screens.secondary, hs.layout.maximized },
		{ apps.slack, nil, screens.secondary, hs.layout.maximized },
		{ apps.linear, nil, screens.secondary, hs.layout.maximized },
		{ apps.figma, nil, screens.secondary, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.secondary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.primary, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
	})
end)

--- Split layout, browser on left of main screen, kitty on right of main screen.
--- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(constants.keys.layer_key, "i", function()
	layout.apply_layout({
		{ apps.categories.browser, nil, screens.laptop, hs.layout.left50 },
		{ apps.categories.terminal, nil, screens.laptop, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.laptop, hs.layout.maximized },
		{ apps.slack, nil, screens.laptop, hs.layout.maximized },
		{ apps.linear, nil, screens.laptop, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.laptop, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.left50 },
		{ apps.zoom, "Zoom Workplace", screens.laptop, layout.put_left },
	}, {
		{ apps.categories.browser, nil, screens.primary, hs.layout.left50 },
		{ apps.categories.terminal, nil, screens.primary, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.primary, hs.layout.maximized },
		{ apps.slack, nil, screens.primary, hs.layout.maximized },
		{ apps.linear, nil, screens.primary, hs.layout.maximized },
		{ apps.figma, nil, screens.primary, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.primary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.primary, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
	}, {
		{ apps.categories.browser, nil, screens.primary, hs.layout.left50 },
		{ apps.categories.terminal, nil, screens.primary, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.secondary, hs.layout.maximized },
		{ apps.slack, nil, screens.secondary, hs.layout.maximized },
		{ apps.linear, nil, screens.secondary, hs.layout.maximized },
		{ apps.figma, nil, screens.secondary, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.secondary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.primary, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
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
		:setAppFilter(apps.zoom)
		:subscribe(hs.window.filter.windowCreated, utils.focus("on"))
		:subscribe(hs.window.filter.windowTitleChanged, utils.focus("on"))
		:subscribe(hs.window.filter.windowDestroyed, utils.focus("off"))
end

--- Media management
hs.hotkey.bind({ "option" }, "p", utils.media("playpause"))
hs.hotkey.bind({ "option" }, "n", utils.media("next"))

-- Sleep
hs.hotkey.bind({ "cmd" }, "f6", function()
	hs.caffeinate.systemSleep()
end)

-- Toggle system appearance
hs.hotkey.bind(nil, "f6", function()
	hs.osascript.applescript([[
    tell application "System Events"
      tell appearance preferences
        set dark mode to not dark mode
      end tell
    end tell
  ]])
end)
