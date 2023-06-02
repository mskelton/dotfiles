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
