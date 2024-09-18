--- vim:set colorcolumn=100:

--- Disable animations
hs.window.animationDuration = 0

--- Disable notification about spotlight search
hs.application.enableSpotlightForNameSearches(false)

--- Hotkeys
--- local hyper = { "cmd", "option", "ctrl", "shift" }
--- local meh = { "ctrl", "option", "shift" }
local layer_key = { "cmd", "ctrl" }

--- Browser selection
local browser = "Arc"

--- Check if a file exists at the given path
--- @param filename string
local function file_exists(filename)
	local file = io.open(filename, "r")
	if file then
		file:close()
		return true
	end

	return false
end

--- Get the user home directory
--- @return string
local function home_dir()
	return os.getenv("HOME") or ""
end

--- Check if we are at work by looking for a ~/.work file
local is_work = file_exists(home_dir() .. "/.work")

--- Returns the first argument if at work, otherwise the second
--- @param work any
--- @param home any
local function if_work(work, home)
	if is_work then
		return work
	end

	return home
end

--- Screens
local screens = {
	laptop = "Built-in Retina Display",
	primary = "LG HDR 4K",
	secondary = "LG Ultra HD",
}

--- Debugging
function P(...)
	print(hs.inspect.inspect(...))
end

--- Load SpoonInstall to install Spoons
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = false
Install = spoon.SpoonInstall

--- Autocompletion for Hammerspoon config. This is disabled since it's slow to
--- load, so I only enable it when I need to regenerate types.
Install:andUse("EmmyLua", { disable = true })

--- Live reload config
Install:andUse("ReloadConfiguration", { start = true })

--- Launch common apps
Install:andUse("AppLauncher", {
	config = {
		modifiers = layer_key,
	},
	hotkeys = {
		--- Home row
		h = "Finder",
		j = browser,
		k = "kitty",
		l = if_work("Slack", "Telegram"),
		[";"] = if_work(nil, "Mimestream"),
		--- Bottom row
		n = "Todoist",
		m = "Figma",
		["."] = if_work("zoom.us", nil),
		[","] = "ChatGPT",
		["/"] = if_work("Linear", "Google Chrome"),
	},
})

local disabled_apps = if_work({ "Postman" }, { "Postman", "Slack", "Linear" })

--- Apply a layout based on the number of screens
local function apply_layout(...)
	local layouts = { ... }
	local count = #hs.screen.allScreens()
	local layout = layouts[count]

	layout = hs.fnutils.ifilter(layout, function(app)
		return not hs.fnutils.contains(disabled_apps, app[1])
	end)

	hs.layout.apply(layout)
end

--- Get's the Mimestream inbox window. We don't want to maximize draft emails
--- since they are not full size.
local function get_mimestream_window()
	local app = hs.application.get("Mimestream")
	if app == nil then
		return {}
	end

	local inbox = app:findWindow("Inbox.*")
	if inbox == nil then
		return {}
	end

	return { inbox }
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

--- Puts a window on the right side of the screen without resizing it
--- @param window hs.window
--- @diagnostic disable-next-line: unused-local, unused-function
local function put_right(window)
	local screen = window:screen():frame()
	local frame = window:frame()

	return hs.geometry
		.rect(
			screen.x + (screen.w / 2) + (frame.w / 2),
			screen.y + (screen.h / 2) - (frame.h / 2),
			frame.w,
			frame.h
		)
		:toUnitRect(screen)
end

--- Main layout, browser on right most screen, Figma behind browser, kitty on
--- main screen. Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "u", function()
	apply_layout({
		{ browser, nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
		{ "Zoom", "Zoom", screens.laptop, put_center, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		--- Laptop
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
		--- Primary
		{ browser, nil, screens.primary, hs.layout.maximized, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.maximized, nil, nil },
		--- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "ChatGPT", nil, screens.secondary, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.secondary, hs.layout.maximized, nil, nil },
	})
end)

--- Split layout, browser on left of main screen, kitty on right of main screen.
--- Figma maximized on the right most screen, Email/Slack on left most screen.
hs.hotkey.bind(layer_key, "i", function()
	apply_layout({
		{ browser, nil, screens.laptop, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.left50, nil, nil },
		{ "Zoom", "Zoom", screens.laptop, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		--- Laptop
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom", screens.laptop, put_center, nil, nil },
		--- Primary
		{ browser, nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		--- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "ChatGPT", nil, screens.secondary, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.secondary, hs.layout.maximized, nil, nil },
	})
end)

--- Zoom layout, browser and kitty on left of main screen, Zoom on the right of
--- main screen. Figma maximized on the right most screen, Email/Slack on left
--- most screen.
hs.hotkey.bind(layer_key, "o", function()
	apply_layout({
		{ browser, nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "kitty", nil, screens.laptop, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.left50, nil, nil },
		{ "Zoom", "Zoom", screens.laptop, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		--- Primary
		{ browser, nil, screens.primary, hs.layout.right50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.primary, hs.layout.left50, nil, nil },
		{ "Zoom", "Zoom", screens.primary, put_left, nil, nil },
		--- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "ChatGPT", nil, screens.secondary, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.secondary, hs.layout.maximized, nil, nil },
	})
end)

--- Get the focused window and it's max dimensions
local function get_screen_rect()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local max = screen:frame()

	return win, max
end

--- Left half
hs.hotkey.bind({ "cmd", "alt" }, "Left", function()
	local win, max = get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x, max.y, max.w / 2, max.h))
end)

--- Right half
hs.hotkey.bind({ "cmd", "alt" }, "Right", function()
	local win, max = get_screen_rect()
	win:setFrame(hs.geometry.rect(max.x + (max.w / 2), max.y, max.w / 2, max.h))
end)

--- Maximize
hs.hotkey.bind({ "cmd", "alt" }, "f", function()
	local win, max = get_screen_rect()
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

--- Set the focus state
--- @param state string
local function set_focus(state)
	hs.execute("shortcuts run 'Focus' <<<'" .. state .. "'")
end

--- Returns a function that sets the focus state
--- @param state string
local function focus(state)
	return function()
		set_focus(state)
	end
end

--- TODO: Re-enable this, but it's horrifically slow to start
--- Manage focus when in Zoom meetings
--- if is_work then
--- 	hs.window.filter.default
--- 		:setAppFilter("zoom.us")
--- 		:subscribe(hs.window.filter.windowCreated, focus("on"))
--- 		:subscribe(hs.window.filter.windowTitleChanged, focus("on"))
--- 		:subscribe(hs.window.filter.windowDestroyed, focus("off"))
--- end

--- Music management
--- @param arg string
local function media(arg)
	return function()
		hs.execute("shortcuts run 'Media' <<<'" .. arg .. "'")
	end
end

hs.hotkey.bind({ "option" }, "p", media("playpause"))
hs.hotkey.bind({ "option" }, "n", media("next"))

--- Execute a shell command asynchronously
--- @param command string
--- @param args string[]
--- @param callback fun()|nil
local function execute_async(command, args, callback)
	hs.task.new(command, callback, args):start()
end

--- Restart Bluetooth
local function restart_bluetooth()
	--- TODO: Document permission requirements for hammerspoon bluetooth
	local bin = "/opt/homebrew/bin/blueutil"

	execute_async(bin, { "--power", "0" }, function()
		execute_async(bin, { "--power", "1" })
	end)
end

--- Get a menu icon from a PNG file
--- @param filename string
--- @return hs.image|nil
local function get_menu_icon(filename)
	--- @type hs.image|nil
	local image = hs.image.imageFromPath(home_dir() .. "/.hammerspoon/assets/" .. filename)
	if image == nil then
		return nil
	end

	return image:setSize({ w = 20, h = 20 })
end

if is_work then
	--- @type hs.menubar|nil
	BluetoothMenu = hs.menubar.new(true, "bluetooth_restart")
	BluetoothMenu:setIcon(get_menu_icon("bluetooth.png"))
	BluetoothMenu:setClickCallback(restart_bluetooth)
end
