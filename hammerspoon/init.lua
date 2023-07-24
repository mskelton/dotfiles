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

--- Raise all windows of the given apps
--- @param apps table
local function raise(apps)
	local app

	for _, value in ipairs(apps) do
		if type(value) == "string" then
			value = hs.application.find(value)
		end

		if value == nil then
			goto continue
		end

		-- Raise all windows of the app if it's open
		if getmetatable(value).__name == "hs.application" then
			for _, window in ipairs(value:allWindows()) do
				window:raise()
			end
		else
			value:raise()
		end

		::continue::
	end

	-- Focus the main window of the last app. This is necessary for some reason
	-- otherwise, the raise operation doesn't do anything.
	if app then
		app:mainWindow():focus()
	end
end

-- Main layout, browser on right most screen, Figma behind browser, kitty on
-- main screen. Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "u", function()
	apply_layout({
		{ "Arc", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {
		-- Primary
		{ "kitty", nil, screens.primary, hs.layout.maximized, nil, nil },
		-- Secondary
		{ "Arc", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.secondary, hs.layout.left50, nil, nil },
		{ "Mimestream", nil, screens.secondary, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
	}, {
		-- Primary
		{ "kitty", nil, screens.primary, hs.layout.maximized, nil, nil },
		-- Secondary
		{ "Arc", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
		-- Laptop
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})

	hs.timer.doAfter(0.2, function()
		raise({ "Arc", "kitty" })
	end)
end)

-- Split layout, browser on left of main screen, kitty on right of main screen.
-- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "i", function()
	apply_layout({
		{ "Arc", nil, screens.laptop, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {
		-- Primary
		{ "Arc", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		-- Secondary
		{ "Slack", nil, screens.secondary, hs.layout.left50, nil, nil },
		{ "Mimestream", nil, screens.secondary, hs.layout.right50, nil, nil },
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
	}, {
		-- Primary
		{ "Arc", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
		-- Laptop
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})

	hs.timer.doAfter(0.2, function()
		raise({ "Arc", "kitty", "Mimestream", "Slack" })
	end)
end)

-- Zoom layout, browser and kitty on left of main screen, Zoom on the right of
-- main screen. Figma maximized on the right most screen, Email/Slack on left
-- most screen.
hs.hotkey.bind(layer_key, "o", function()
	apply_layout({
		{ "Arc", nil, screens.laptop, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.left50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.right50, nil, nil },
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {
		-- Primary
		{ "Arc", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.primary, hs.layout.right50, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Mimestream", nil, screens.secondary, hs.layout.left50, nil, nil },
		{ "Slack", nil, screens.secondary, hs.layout.right50, nil, nil },
	}, {
		-- Primary
		{ "Arc", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.left50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.primary, hs.layout.right50, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		-- Laptop
		{ "Mimestream", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})

	hs.timer.doAfter(0.2, function()
		raise({
			"Arc",
			"kitty",
			hs.window.find("Zoom Meeting"),
		})
	end)
end)

-- Bring messaging to front, or send to back
hs.hotkey.bind(layer_key, "p", function()
	local focused_window = hs.window.focusedWindow()
	local title = focused_window:application():title()

	if title == "Mimestream" or title == "Slack" then
		raise({ "Arc", "kitty" })
	else
		raise({ "Mimestream", "Slack" })
	end
end)

-- Escape paste-blocking
hs.hotkey.bind({ "cmd", "alt" }, "v", function()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
