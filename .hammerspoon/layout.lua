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

--- Get the focused window and it's max dimensions
--- @return hs.window, hs.geometry
M.get_screen_rect = function()
	local win = hs.window.focusedWindow()
	local screen = win:screen()
	local max = screen:frame()

	return win, max
end

return M
