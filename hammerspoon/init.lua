--- @diagnostic disable: undefined-global

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

-- hs.hotkey.bind({ "cmd", "ctrl" }, "m", function()
-- 	hs.notify.new({ title = "Hammerspoon", informativeText = "Hello World" }):send()
-- end)

-- Main layout, browser on right most screen, Figma behind browser, Kitty on
-- main screen. Email/Slack on left most screen.

-- Split layout, browser on left of main screen, Kitty on right of main screen.
-- Figma maximized on the right most screen, Email/Slack on left most screen.
