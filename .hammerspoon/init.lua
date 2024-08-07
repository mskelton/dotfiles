--- @diagnostic disable: undefined-global
--- vim:set colorcolumn=100:

hs.console.consoleFont("JetBrains Mono")

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

--- Custom layouts
local layout = {
	left65 = hs.geometry.rect(0, 0, 0.65, 1),
	right35 = hs.geometry.rect(0.65, 0, 0.35, 1),
}

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

--- Check if we are at work by looking for a ~/.work file
local is_work = file_exists(os.getenv("HOME") .. "/.work")

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
		[";"] = "Mimestream",
		--- Bottom row
		n = "Todoist",
		m = "zoom.us",
		[","] = "ChatGPT",
		["."] = "Figma",
		["/"] = "Linear",
	},
})

local disabled_apps = if_work({ "Around", "Postman" }, {
	"Around",
	"Postman",
	"Slack",
	"Linear",
})

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

--- Returns true if the window is the Around lobby window. This is a guess based on size.
--- @param window hs.window
local function is_around_lobby(window)
	local size = window:size()
	return size.h < 800 or size.w < 1000
end

--- Places the Around window in the desired position. This is required since Around uses the same
--- name for both the lobby and the meeting window, so we have to use a heuristic to determine
--- if we are placing the lobby or the main meeting window.
local function place_around(lobby, meeting)
	--- @param window hs.window
	return function(window)
		local placement = meeting

		if is_around_lobby(window) then
			placement = lobby
		end

		if type(placement) == "function" then
			return placement(window)
		end

		return placement
	end
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
		{ "Around", nil, screens.laptop, place_around(put_center, hs.layout.maximized), nil, nil },
		{ "Mimestream", get_mimestream_window, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.laptop, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		-- Primary
		{ browser, nil, screens.primary, hs.layout.maximized, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.maximized, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
		{ "Around", nil, screens.secondary, place_around(put_center, hs.layout.maximized), nil, nil },
		{ "ChatGPT", nil, screens.secondary, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.secondary, layout.right35, nil, nil },
		{ "Slack", nil, screens.secondary, layout.left65, nil, nil },
		{ "Postman", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
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
		{ "Around", nil, screens.laptop, place_around(put_left, hs.layout.left50), nil, nil },
		{ "Mimestream", get_mimestream_window, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		-- Primary
		{ browser, nil, screens.primary, hs.layout.left50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.secondary, hs.layout.maximized, nil, nil },
		{ "zoom.us", "Zoom", screens.secondary, put_center, nil, nil },
		{
			"Around",
			nil,
			screens.secondary,
			place_around(put_center, hs.layout.maximized),
			nil,
			nil,
		},
		{ "ChatGPT", nil, screens.secondary, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.secondary, layout.right35, nil, nil },
		{ "Slack", nil, screens.secondary, layout.left65, nil, nil },
		{ "Postman", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
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
		{ "Around", nil, screens.laptop, place_around(put_left, hs.layout.left50), nil, nil },
		{ "Mimestream", get_mimestream_window, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Slack", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Postman", nil, screens.laptop, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	}, {}, {
		-- Primary
		{ browser, nil, screens.primary, hs.layout.right50, nil, nil },
		{ "kitty", nil, screens.primary, hs.layout.right50, nil, nil },
		{ "zoom.us", "Zoom Meeting", screens.primary, hs.layout.left50, nil, nil },
		{ "Zoom", "Zoom", screens.primary, put_left, nil, nil },
		{ "Around", nil, screens.primary, place_around(put_left, hs.layout.left50), nil, nil },
		-- Secondary
		{ "Figma", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "ChatGPT", nil, screens.secondary, put_left, nil, nil },
		{ "Mimestream", get_mimestream_window, screens.secondary, layout.right35, nil, nil },
		{ "Slack", nil, screens.secondary, layout.left65, nil, nil },
		{ "Postman", nil, screens.secondary, hs.layout.maximized, nil, nil },
		{ "Linear", nil, screens.laptop, hs.layout.maximized, nil, nil },
	})
end)

--- Escape paste-blocking
hs.hotkey.bind({ "cmd", "alt" }, "v", function()
	hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

--- Audio presets
hs.hotkey.bind({ "cmd", "ctrl" }, "f9", function()
	hs.audiodevice.defaultOutputDevice():setOutputVolume(30)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "f10", function()
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

--- Manage focus when in Zoom meetings
hs.window.filter
	.new(function(window)
		return window ~= nil and window:title() == "Zoom Meeting"
	end)
	:subscribe(hs.window.filter.windowCreated, focus("on"))
	:subscribe(hs.window.filter.windowTitleChanged, focus("on"))
	:subscribe(hs.window.filter.windowDestroyed, focus("off"))

--- Manage focus when in Around meetings. Around is a little odd. It has a single window title of
--- "Around" shared by the lobby and the meeting window. The lobby window is maximizable, but the
--- floating window is not, so we can use that as the initial test to determine if we are in a
--- meeting. When in a meeting, if switching from floating to the maximized window, we don't want
--- to touch the focus state.
hs.window.filter.new("Around"):subscribe(hs.window.filter.windowCreated, function(window)
	if window:isMaximizable() and is_around_lobby(window) then
		set_focus("off")
	else
		set_focus("on")
	end
end)

--- Music management
--- @param arg string
local function media(arg)
	return function()
		hs.execute("shortcuts run 'Media' <<<'" .. arg .. "'")
	end
end

hs.hotkey.bind({ "option" }, "p", media("playpause"))
hs.hotkey.bind({ "option" }, "n", media("next"))
