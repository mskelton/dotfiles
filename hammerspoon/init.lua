--- @diagnostic disable: undefined-global

hs.console.consoleFont("JetBrains Mono")

-- Disable animations
hs.window.animationDuration = 0

-- Hotkeys
-- local hyper = { "cmd", "option", "ctrl", "shift" }
local layer_key = { "cmd", "ctrl" }

-- Screens
local screens = {
	laptop = "Built-in Retina Display",
	primary = "LG HDR 4K",
	secondary = "LG Ultra HD",
}

-- Debugging
function P(...)
	print(hs.inspect.inspect(...))
end

-- Load SpoonInstall to install Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = false
Install = spoon.SpoonInstall

-- Autocompletion for Hammerspoon config. This is disabled since it's slow to
-- load, so I only enable it when I need to regenerate types.
Install:andUse("EmmyLua", { disable = true })

-- Live reload config
Install:andUse("ReloadConfiguration", { start = true })

-- Launch common apps
Install:andUse("AppLauncher", {
	config = {
		modifiers = layer_key,
	},
	hotkeys = {
		j = "Arc",
		k = "kitty",
		l = "Mimestream",
		[";"] = "Slack",
	},
})

--- Apply a layout based on the number of screens
local function apply_layout(...)
	local layouts = { ... }
	local count = #hs.screen.allScreens()

	hs.layout.apply(layouts[count])
end

--- Get's the active Around meeting window
local function get_around_window(app_name)
	local app = hs.application.get(app_name)
	if app == nil then
		return {}
	end

	-- For some reason, when there is only one window, Around is the name of the
	-- lobby, but when in a meeting, it's the name of the meeting. I only ever
	-- want to move the meeting window.
	if #app:allWindows() == 2 then
		return { app:getWindow("Around") }
	end

	return {}
end

--- Puts a window on the left side of the screen without resizing it
--- @param window hs.window
local function put_left(window)
	local screen = window:screen():frame()
	local frame = window:frame()

	return hs.geometry
		.rect(
			screen.x + (screen.w / 4) - (frame.w / 2),
			screen.y + (screen.h / 2) - (frame.h / 2),
			frame.w,
			frame.h
		)
		:toUnitRect(screen)
end

--- Puts a window in the center side of the screen without resizing it
--- @param window hs.window
local function put_center(window)
	local screen = window:screen():frame()
	local frame = window:frame()

	return hs.geometry
		.rect(
			screen.x + (screen.w / 2) - (frame.w / 2),
			screen.y + (screen.h / 2) - (frame.h / 2),
			frame.w,
			frame.h
		)
		:toUnitRect(screen)
end

-- Main layout, browser on right most screen, Figma behind browser, kitty on
-- main screen. Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "u", function()
	apply_layout({
		{ "Arc", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		-- Primary
		{ "kitty", nil, screens.primary, hs.layout.maximized, nil, nil },
		-- Secondary
		{ "Arc", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
		{ "Around", get_around_window, screens.secondary, hs.layout.maximized, nil, nil },
		-- Laptop
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})
end)

-- Split layout, browser on left of main screen, kitty on right of main screen.
-- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "i", function()
	apply_layout({
		{ "Arc", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.left50, nil, nil },
		{ "zoom.us", "Zoom", screens.laptop, put_left, nil, nil },
		{ "Around", get_around_window, screens.laptop, hs.layout.left50, nil, nil },
		{ "Around", "Around", screens.laptop, put_left, nil, nil },
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		-- Primary
		{ "Arc", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom", screens.laptop, put_center, nil, nil },
		{ "Around", get_around_window, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Around", "Around", screens.laptop, put_center, nil, nil },
		-- Laptop
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})
end)

-- Zoom layout, browser and kitty on left of main screen, Zoom on the right of
-- main screen. Figma maximized on the right most screen, Email/Slack on left
-- most screen.
hs.hotkey.bind(layer_key, "o", function()
	apply_layout({
		{ "Arc", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.left50, nil, nil },
		{ "Zoom", "Zoom", screens.primary, put_left, nil, nil },
		{ "Around", get_around_window, screens.primary, hs.layout.left50, nil, nil },
		{ "Around", "Around", screens.primary, put_left, nil, nil },
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		-- Primary
		{ "Arc", nil, screens.primary, hs.layout.right50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.primary, hs.layout.left50, nil, nil },
		{ "Zoom", "Zoom", screens.primary, put_left, nil, nil },
		{ "Around", get_around_window, screens.primary, hs.layout.left50, nil, nil },
		{ "Around", "Around", screens.primary, put_left, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		-- Laptop
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})
end)

-- Escape paste-blocking
hs.hotkey.bind({ "cmd", "alt" }, "v", function()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

-- Audio presets
hs.hotkey.bind({ "cmd", "ctrl" }, "f9", function()
	hs.audiodevice.defaultOutputDevice():setOutputVolume(40)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "f10", function()
	hs.audiodevice.defaultOutputDevice():setOutputVolume(80)
end)
