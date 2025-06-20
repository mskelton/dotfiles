local M = {}

--- Metadata
M.name = "GitHubNotifications"
M.version = "1.0"
M.author = "Mark Skelton <mark@mskelton.dev>"
M.homepage = "https://github.com/mskelton/dotfiles"
M.license = "ISC - https://opensource.org/licenses/ISC"

M.log = hs.logger.new("gh_notif", "debug")

--- The current count of notifications
--- @type number|nil
M.count = nil

--- Get the icon for the menu bar
--- @param filename string
--- @return hs.image|nil
local function get_icon(filename)
	--- @type hs.image|nil
	local icon =
			hs.image.imageFromPath(hs.configdir .. "/Spoons/GitHubNotifications.spoon/" .. filename)

	if icon == nil then
		return nil
	end

	return icon:setSize({ w = 16, h = 16 })
end

local readIcon = get_icon("github-read.png")
local unreadIcon = get_icon("github-unread.png")

--- Sends a notification if the count of unread notifications is greater than
--- the current count.
--- @param count number
function M:maybe_notify(count)
	if self.count == nil then
		return
	end

	if count > self.count then
		--- @type hs.notify|nil
		local notification = hs.notify.new(function()
			hs.urlevent.openURL("https://github.com/notifications?query=is%3Aunread")
		end, {
			title = "GitHub",
			informativeText = "You have " .. count .. " unread notifications",
			soundName = "submarine",
		})

		if notification then
			notification:send()
		end
	end
end

--- Updates the count of unread notifications
--- @param count number
function M:update_count(count)
	if count > 0 then
		self:maybe_notify(count)
		self.menu:setIcon(unreadIcon)
		self.menu:setTitle(tostring(count))
	else
		self.menu:setIcon(readIcon)
		self.menu:setTitle(nil)
	end

	self.count = count
end

--- Shows an error notification
--- @param message string
local function show_error(message)
	hs
			.notify
			.new({
				title = "GitHub Notifications",
				informativeText = message,
				soundName = "Submarine",
			})
	--- @diagnostic disable-next-line: undefined-field
			:send()
end

--- Callback fired when the timer triggers
--- @param source string
function M:sync(source)
	self.log.d("Syncing GitHub notifications. Triggerd by " .. source)

	hs.http.doAsyncRequest("https://api.github.com/notifications", "GET", nil, {
		["Accept"] = "application/vnd.github.v3+json",
		["Authorization"] = "token " .. self.token,
		["Content-Type"] = "application/json",
	}, function(status, body)
		--- Ignore error if offline
		if status == -1 then
			self.log.d("Failed to fetch GitHub notifications: Offline")
			return nil
		end

		if status ~= 200 then
			show_error("Failed to fetch GitHub notifications")
			return nil
		end

		local notifications = hs.json.decode(body)
		if notifications == nil then
			show_error("Unexpected JSON response")
			return nil
		end

		self.log.d("Received " .. #notifications .. " notifications")
		self.log.d("Last checked: " .. (self.last_checked or "nil"))
		self.log.d(hs.inspect(notifications))

		notifications = hs.fnutils.filter(notifications, function(notification)
			--- Ignore read notifications
			if notification.unread == false then
				return true
			end

			--- If we haven't checked before, assume all are unread
			if not self.last_checked then
				return true
			end

			--- Turns out this is a nullable field
			if not notification.last_read_at then
				return true
			end

			--- Compare the last time notifications were checked to when the
			--- notifications where last viewed on GitHub.
			return notification.last_read_at > self.last_checked
		end)

		self.log.d("Unread notifications: " .. #notifications)
		self:update_count(#notifications)
	end, "ignoreLocalAndRemoteCache")
end

--- Get a setting value
--- @param key string
--- @param func fun(): any
--- @param ignore_cache boolean|nil
local function get_setting(key, func, ignore_cache)
	local value = hs.settings.get(key)
	if value ~= nil and not ignore_cache then
		return value
	end

	value = func()
	if value ~= nil then
		hs.settings.set(key, value)
	end

	return value
end

--- Get the GitHub token from the settings
--- @param ignore_cache boolean|nil
--- @return string|nil
function M:get_token(ignore_cache)
	self.token = get_setting("github_token", function()
		local button, token = hs.dialog.textPrompt("Enter GitHub Token", "", "", "Save", "Cancel")

		if button == "Save" and token ~= "" then
			return token
		end

		return nil
	end, ignore_cache)
end

--- Open the GitHub notifications page and clear the count
function M:open_notifications()
	self.last_checked = os.date("!%Y-%m-%dT%H:%M:%SZ")
	self:update_count(0)
	hs.urlevent.openURL("https://github.com/notifications?query=is%3Aunread")
end

--- Delete the menu bar icon
function M:delete_menu()
	if self.menu then
		self.menu:delete()
		self.menu = nil
	end
end

function M:start()
	self:get_token()

	if self.menu then
		self.menu:returnToMenuBar()
	else
		--- @type hs.menubar|nil
		self.menu = hs.menubar.new(true, "GitHubNotifications")
		self.menu:setTooltip("GitHub Notifications")
		self.menu:setIcon(readIcon)
		self.menu:setMenu(function(modifiers)
			--- Only open the submenu if the user is holding the control key
			if not modifiers.ctrl then
				self:open_notifications()
				return {}
			end

			return {
				{
					title = "Open Notifications",
					fn = hs.fnutils.partial(self.open_notifications, self),
				},
				{
					title = "Set GitHub Token",
					fn = hs.fnutils.partial(self.get_token, self, true),
				},
			}
		end)
	end

	self.timer = hs.timer.new(self.interval or 60, function()
		self:sync("timer")
	end)
	self.timer:start()
	self.timer:fire()

	--- @type hs.ipc|nil
	self.ipc = hs.ipc.localPort("github-notifications", function(_, _, data)
		if data == "xclear" then
			self:update_count(0)
		elseif data == "xsync" then
			self:sync("ipc")
		end
	end)

	return self
end

function M:stop()
	if self.menu then
		self:delete_menu()
	end

	if self.timer then
		self.timer:stop()
	end

	if self.ipc then
		self.ipc:delete()
	end

	return self
end

--- Binds hotkeys for the spoon
--- @param mapping table
function M:bindHotkeys(mapping)
	local spec = {
		open = hs.fnutils.partial(self.open_notifications, self),
	}

	hs.spoons.bindHotkeysToSpec(spec, mapping)
	return self
end

return M
