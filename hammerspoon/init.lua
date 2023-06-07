--- @diagnostic disable: undefined-global

hs.console.consoleFont("JetBrains Mono")

-- Disable animations
hs.window.animationDuration = 0

-- Hotkeys
-- local hyper = { "cmd", "option", "ctrl", "shift" }
local layer_key = { "cmd", "ctrl" }

-- Screens
local screens = {
	left = "",
	main = "Built-in Retina Display",
	right = "",
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
		k = "Kitty",
		l = "Mimestream",
		[";"] = "Slack",
	},
})

local function apply_layout(single_layout, multi_layout)
	if #hs.screen.allScreens() == 3 then
		hs.layout.apply(multi_layout)
	else
		hs.layout.apply(single_layout)
	end
end

-- Main layout, browser on right most screen, Figma behind browser, Kitty on
-- main screen. Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "u", function()
	apply_layout({
		{ "Arc", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Kitty", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Mimestream", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.main, hs.layout.maximized, nil, nil },
	}, {
		{ "Arc", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Kitty", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Mimestream", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.main, hs.layout.maximized, nil, nil },
	})
end)

-- Split layout, browser on left of main screen, Kitty on right of main screen.
-- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "i", function()
	apply_layout({
		{ "Arc", nil, screens.main, hs.layout.left50, nil, nil },
		{ "Kitty", nil, screens.main, hs.layout.right50, nil, nil },
		{ "Mimestream", nil, screens.main, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.main, hs.layout.maximized, nil, nil },
	}, {
		{ "Arc", nil, screens.main, hs.layout.left50, nil, nil },
		{ "Kitty", nil, screens.main, hs.layout.right50, nil, nil },
		{ "Mimestream", nil, screens.left, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.left, hs.layout.maximized, nil, nil },
		{ "Figma", nil, screens.right, hs.layout.maximized, nil, nil },
		-- { "zoom.us", nil, screens.right, hs.layout.maximized, nil, nil },
	})
end)

-- Escape paste-blocking
hs.hotkey.bind({ "cmd", "alt" }, "v", function()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)
