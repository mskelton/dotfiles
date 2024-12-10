local M = {}

local constants = require("constants")

--- Apply a layout based on the number of screens
M.apply_layout = function(...)
	local layouts = { ... }
	local count = #hs.screen.allScreens()
	local layout = layouts[count]

	layout = hs.fnutils.ifilter(layout, function(app)
		return not hs.fnutils.contains(constants.disabled_apps, app[1])
	end)

	hs.layout.apply(layout)
end

--- Get a rect for the given screen that represents a maximized window
--- @param screen hs.geometry
--- @return hs.geometry
M.get_maximized_rect = function(screen)
	return hs.geometry.rect(
		screen.x + constants.window_padding,
		screen.y + constants.window_padding,
		screen.w - constants.window_padding * 2,
		screen.h - constants.window_padding * 2
	)
end

--- Get a unit rect for the given screen that represents a maximized window
--- @param window hs.window
M.maximized = function(window)
	local screen = window:screen():frame()
	return M.get_maximized_rect(screen):toUnitRect(screen)
end

--- Get a rect for the given screen that represents the left 50% of the screen
--- @param screen hs.geometry
--- @return hs.geometry
M.get_left50_rect = function(screen)
	return hs.geometry.rect(
		screen.x + constants.window_padding,
		screen.y + constants.window_padding,
		(screen.w / 2) - constants.window_padding * 1.5,
		screen.h - constants.window_padding * 2
	)
end

--- Get a unit rect for the given screen that represents the left 50% of the screen
--- @param window hs.window
M.left50 = function(window)
	local screen = window:screen():frame()
	return M.get_left50_rect(screen):toUnitRect(screen)
end

--- Get a rect for the given screen that represents the right 50% of the screen
--- @param screen hs.geometry
--- @return hs.geometry
M.get_right50_rect = function(screen)
	return hs.geometry.rect(
		screen.x + (screen.w / 2) + constants.window_padding / 2,
		screen.y + constants.window_padding,
		(screen.w / 2) - constants.window_padding * 1.5,
		screen.h - constants.window_padding * 2
	)
end

--- Get a unit rect for the given screen that represents the right 50% of the screen
--- @param window hs.window
M.right50 = function(window)
	local screen = window:screen():frame()
	return M.get_right50_rect(screen):toUnitRect(screen)
end

--- Get the focused window and it's max dimensions
--- @return hs.window, hs.geometry
M.get_screen_rect = function()
	local win = hs.window.focusedWindow()
	local screen = win:screen():frame()

	return win, screen
end

--- Get's the Mimestream inbox window. We don't want to maximize draft emails
--- since they are not full size.
M.mimestream_inbox = function()
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
M.put_left = function(window)
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
M.put_center = function(window)
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
M.put_right = function(window)
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

--- @class Options
--- @field show string[]
--- @field hide string[]

--- Pulls the specified app windows forward, focusing the last one in the list
--- @param options Options
M.pull_forward = function(options)
	local are_apps_foremost = M.are_apps_foremost(options.show)

	--- Hide all apps no longer needed
	for _, app_name in ipairs(options.hide) do
		hs.application.get(app_name):hide()
	end

	for i, app_name in ipairs(options.show) do
		--- For each app other than the last app, conditionally launch/focus them
		--- if they are not already foremost
		if i < #options.show and not are_apps_foremost then
			hs.timer.doAfter(0.1 * i, function()
				hs.application.get(app_name):mainWindow():raise()
			end)
		end

		--- Always launch/focus the last app in the list
		if i == #options.show then
			hs.application.launchOrFocus(app_name)
		end
	end
end

--- Determine if there are any other windows that are above the specified apps
--- If there are, we want to focus each application in order to raise them up.
--- @param apps string[]
M.are_apps_foremost = function(apps)
	local ordered_windows = hs.window.orderedWindows()

	--- @type table<string, boolean>
	local seen_apps = {}

	for _, window in ipairs(ordered_windows) do
		--- @type hs.application|nil
		local app = window:application()
		if app == nil then
			goto continue
		end

		if hs.fnutils.contains(apps, app:title()) then
			seen_apps[app:title()] = true
		elseif #apps == M.tbl_count(seen_apps) then
			--- I've we've seen all the apps specified by the time we find a
			--- non-specified app, the specified apps are foremost.
			return true
		else
			--- If we find a non-specified app before we've seen all the specified
			--- apps, then the specified apps are not foremost.
			return false
		end

		::continue::
	end

	return true
end

--- Count the number of keys in a table
--- @param tbl table
M.tbl_count = function(tbl)
	local count = 0

	for _ in pairs(tbl) do
		count = count + 1
	end

	return count
end

--- Focuses the specified app if it's running, otherwise noop
--- @param hint string
M.maybe_focus = function(hint)
	local app = hs.application.get(hint)
	if app == nil then
		return
	end

	app:activate()
end

return M
