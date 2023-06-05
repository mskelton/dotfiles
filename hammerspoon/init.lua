--- @diagnostic disable: undefined-global

hs.console.consoleFont("JetBrains Mono")

-- Make all our animations really fast
hs.window.animationDuration = 0.1

-- Hotkeys
-- local hyper = { "cmd", "option", "ctrl", "shift" }
local layer_key = { "cmd", "ctrl" }

--- Live reload config
function LiveReload(files)
	for _, file in pairs(files) do
		if file:sub(-4) == ".lua" then
			hs.reload()
			return
		end
	end
end

local config_path = os.getenv("HOME") .. "/.hammerspoon/"
LiveReloadWatcher = hs.pathwatcher.new(config_path, LiveReload):start()

-- Load SpoonInstall to install Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install = spoon.SpoonInstall

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

-- hs.hotkey.bind(layer_key, "i", function()
-- 	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
-- end)
--
-- hs.hotkey.bind(layer_key, "i", function()
-- 	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
-- end)
--
-- hs.hotkey.bind(layer_key, "i", function()
-- 	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
-- end)
--
-- -- Main layout, browser on right most screen, Figma behind browser, Kitty on
-- -- main screen. Email/Slack on left most screen.
--
-- -- Split layout, browser on left of main screen, Kitty on right of main screen.
-- -- Figma maximized on the right most screen, Email/Slack on left most screen.
