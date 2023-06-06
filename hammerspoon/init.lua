--- @diagnostic disable: undefined-global

hs.console.consoleFont("JetBrains Mono")

-- Make all our animations really fast
hs.window.animationDuration = 0.1

-- Hotkeys
-- local hyper = { "cmd", "option", "ctrl", "shift" }
local layer_key = { "cmd", "ctrl" }

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

-- Main layout, browser on right most screen, Figma behind browser, Kitty on
-- main screen. Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "u", function()
	-- hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
end)

-- Split layout, browser on left of main screen, Kitty on right of main screen.
-- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "i", function()
	-- hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
end)
