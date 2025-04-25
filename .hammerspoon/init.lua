--- vim:set colorcolumn=100:

local apps = require("apps")
local constants = require("constants")
local utils = require("utils")
local layout = require("layout")
local screens = constants.screens

--- Disable animations
hs.window.animationDuration = 0

--- Disable notification about spotlight search
hs.application.enableSpotlightForNameSearches(false)

--- Install the CLI
hs.ipc.cliInstall()

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
	start = true,
})

Install:andUse("FocusManager", {
	start = true,
})

Install:andUse("Remote", {
	disable = utils.is_work,
	start = true,
	config = {
		port = 27381,
	},
})

Install:andUse("GitHubNotifications", {
	disable = not utils.is_work,
	start = true,
	hotkeys = {
		open = { constants.keys.layer_key, "p" },
	},
	config = {
		interval = 60,
	},
})

hs.hotkey.bind(constants.keys.layer_key, "h", function()
	hs.application.launchOrFocus(apps.chat_gpt)
end)

hs.hotkey.bind(constants.keys.layer_key, "j", function()
	hs.application.launchOrFocus(apps.arc)
end)

hs.hotkey.bind(constants.keys.layer_key, "k", function()
	hs.application.launchOrFocus(apps.kitty)
end)

hs.hotkey.bind(constants.keys.layer_key, "l", function()
	hs.application.launchOrFocus(utils.if_work(apps.slack, apps.telegram))
end)

if utils.is_work then
	hs.hotkey.bind(constants.keys.layer_key, ";", function()
		hs.eventtap.keyStroke({ "option", "shift" }, "down")
	end)
end

hs.hotkey.bind(constants.keys.layer_key, "n", function()
	hs.application.launchOrFocus(utils.if_work(apps.linear, apps.todoist))
end)

hs.hotkey.bind(constants.keys.layer_key, "m", function()
	hs.application.launchOrFocus(apps.notion)
end)

hs.hotkey.bind(constants.keys.layer_key, ",", function()
	hs.application.launchOrFocus(apps.cursor)
end)

hs.hotkey.bind(constants.keys.layer_key, ".", function()
	hs.application.launchOrFocus(apps.figma)
end)

hs.hotkey.bind(constants.keys.layer_key, "/", function()
	if utils.is_work then
		layout.maybe_focus(apps.zoom)
	end
end)

hs.hotkey.bind(constants.keys.layer_key, "u", function()
	layout.apply_layout({
		{ apps.arc, nil, screens.laptop, hs.layout.maximized },
		{ apps.kitty, nil, screens.laptop, hs.layout.maximized },
		{ apps.cursor, nil, screens.laptop, hs.layout.maximized },
		{ apps.mimestream, layout.mimestream_inbox, screens.laptop, hs.layout.maximized },
		{ apps.slack, nil, screens.laptop, hs.layout.maximized },
		{ apps.linear, nil, screens.laptop, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.notion, nil, screens.laptop, layout.maximized },
		{ apps.chat_gpt, nil, screens.laptop, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.laptop, layout.put_center },
	}, {
		{ apps.arc, nil, screens.primary, hs.layout.maximized },
		{ apps.kitty, nil, screens.primary, hs.layout.maximized },
		{ apps.cursor, nil, screens.primary, hs.layout.maximized },
		{ apps.mimestream, layout.mimestream_inbox, screens.primary, hs.layout.maximized },
		{ apps.slack, nil, screens.primary, hs.layout.maximized },
		{ apps.linear, nil, screens.primary, hs.layout.maximized },
		{ apps.figma, nil, screens.primary, hs.layout.maximized },
		{ apps.notion, nil, screens.primary, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.primary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
	})
end)

hs.hotkey.bind(constants.keys.layer_key, "i", function()
	layout.apply_layout({
		{ apps.arc, nil, screens.laptop, hs.layout.left50 },
		{ apps.kitty, nil, screens.laptop, hs.layout.right50 },
		{ apps.cursor, nil, screens.laptop, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.laptop, hs.layout.maximized },
		{ apps.slack, nil, screens.laptop, hs.layout.maximized },
		{ apps.linear, nil, screens.laptop, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.notion, nil, screens.laptop, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.laptop, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.left50 },
		{ apps.zoom, "Zoom Workplace", screens.laptop, layout.put_left },
	}, {
		{ apps.arc, nil, screens.primary, hs.layout.left50 },
		{ apps.kitty, nil, screens.primary, hs.layout.right50 },
		{ apps.cursor, nil, screens.primary, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.primary, hs.layout.maximized },
		{ apps.slack, nil, screens.primary, hs.layout.maximized },
		{ apps.linear, nil, screens.primary, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.notion, nil, screens.primary, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.primary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
	})
end)

hs.hotkey.bind(constants.keys.layer_key, "o", function()
	layout.apply_layout({
		{ apps.arc, nil, screens.laptop, hs.layout.left50 },
		{ apps.kitty, nil, screens.laptop, hs.layout.right50 },
		{ apps.cursor, nil, screens.laptop, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.laptop, hs.layout.maximized },
		{ apps.slack, nil, screens.laptop, hs.layout.maximized },
		{ apps.linear, nil, screens.laptop, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.notion, nil, screens.laptop, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.laptop, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.laptop, hs.layout.left50 },
		{ apps.zoom, "Zoom Workplace", screens.laptop, layout.put_left },
	}, {
		{ apps.arc, nil, screens.primary, hs.layout.left50 },
		{ apps.cursor, nil, screens.primary, hs.layout.right50 },
		{ apps.mimestream, layout.mimestream_inbox, screens.primary, hs.layout.maximized },
		{ apps.slack, nil, screens.primary, hs.layout.maximized },
		{ apps.linear, nil, screens.primary, hs.layout.maximized },
		{ apps.figma, nil, screens.laptop, hs.layout.maximized },
		{ apps.notion, nil, screens.laptop, hs.layout.maximized },
		{ apps.chat_gpt, nil, screens.primary, layout.put_left },
		{ apps.zoom, "Zoom Meeting", screens.primary, hs.layout.maximized },
		{ apps.zoom, "Zoom Workplace", screens.primary, layout.put_center },
	})
end)

--- Left half
hs.hotkey.bind({ "cmd", "option" }, "Left", function()
	local win, max = layout.get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x, max.y, max.w / 2, max.h))
end)

--- Right half
hs.hotkey.bind({ "cmd", "option" }, "Right", function()
	local win, max = layout.get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x + (max.w / 2), max.y, max.w / 2, max.h))
end)

--- Maximize
hs.hotkey.bind({ "cmd", "option" }, "f", function()
	local win, max = layout.get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x, max.y, max.w, max.h))
end)

--- Move window to the previous display
hs.hotkey.bind(constants.keys.meh, "Left", function()
	local win = hs.window.focusedWindow()
	local prevScreen = win:screen():toWest()
	win:moveToScreen(prevScreen)
end)

--- Move window to the next display
hs.hotkey.bind(constants.keys.meh, "Right", function()
	local win = hs.window.focusedWindow()
	local nextScreen = win:screen():toEast()
	win:moveToScreen(nextScreen)
end)

--- Escape paste-blocking
hs.hotkey.bind({ "cmd", "option" }, "v", function()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

--- Audio presets
hs.hotkey.bind(constants.keys.layer_key, "f9", function()
	--- @diagnostic disable-next-line: undefined-field
	hs.audiodevice.defaultOutputDevice():setOutputVolume(30)
end)

hs.hotkey.bind(constants.keys.layer_key, "f10", function()
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

--- Play/pause media
hs.hotkey.bind({ "option" }, ";", function()
	utils.media("toggle")
end)

--- Go to next track
hs.hotkey.bind({ "option" }, "n", function()
	utils.media("next")
end)

--- Focus
hs.hotkey.bind({ "option" }, "f", function()
	hs.urlevent.openURL("raycast://focus/complete")
	hs.urlevent.openURL("raycast://focus/start?duration=1800")
end)

--- Take a break
hs.hotkey.bind({ "option" }, "b", function()
	hs.urlevent.openURL("raycast://focus/complete")
	utils.media("pause")
	hs.caffeinate.systemSleep()
end)

--- Open dev server
hs.hotkey.bind({ "control", "option", "shift" }, "d", function()
	if utils.is_work then
		hs.urlevent.openURL("http://localhost:3000/treasury")
	else
		hs.urlevent.openURL("http://localhost:3000")
	end
end)

--- Open Ryu
hs.hotkey.bind({ "control", "option", "shift" }, "r", function()
	if utils.is_work then
		hs.urlevent.openURL("http://localhost:5555")
	end
end)

--- Open QA
hs.hotkey.bind({ "control", "option", "shift" }, "q", function()
	if utils.is_work then
		hs.urlevent.openURL("https://qa.ramp.com/treasury")
	end
end)

--- Sleep
hs.hotkey.bind({ "cmd" }, "f6", function()
	hs.caffeinate.systemSleep()
end)

--- Toggle system appearance
hs.hotkey.bind(nil, "f6", function()
	hs.osascript.applescript([[
    tell application "System Events"
      tell appearance preferences
        set dark mode to not dark mode
      end tell
    end tell
  ]])
end)

--- Toggle input source
hs.hotkey.bind(constants.keys.layer_key, "t", function()
	local layouts = hs.keycodes.layouts()
	local currentLayout = hs.keycodes.currentLayout()

	if not layouts then
		return
	end

	--- Find the next layout in order, cycling around to the start
	local nextLayout = layouts[1]
	for i, l in ipairs(layouts) do
		if l == currentLayout then
			nextLayout = layouts[i + 1] or layouts[1]
			break
		end
	end

	hs.keycodes.setLayout(nextLayout)
end)
