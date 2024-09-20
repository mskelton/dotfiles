local M = {}

--- Metadata
M.name = "GitHubNotifications"
M.version = "1.0"
M.author = "Mark Skelton <mark@mskelton.dev>"
M.homepage = "https://github.com/mskelton/dotfiles"
M.license = "ISC - https://opensource.org/licenses/ISC"

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

--- Updates the count of unread notifications
--- @param count number
function M:update_count(count)
	if count > 0 then
		self.menu:setIcon(unreadIcon)
		self.menu:setTitle(tostring(count))
	else
		self.menu:setIcon(readIcon)
		self.menu:setTitle(nil)
	end
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
function M:on_timer()
	hs.http.doAsyncRequest("https://api.github.com/notifications", "GET", nil, {
		["Accept"] = "application/vnd.github.v3+json",
		["Authorization"] = "token " .. self.token,
		["Content-Type"] = "application/json",
	}, function(status, body)
		if status ~= 200 then
			show_error("Failed to fetch GitHub notifications")
			return nil
		end

		local notifications = hs.json.decode(body)
		if notifications == nil then
			show_error("Unexpected JSON response")
			return nil
		end

		notifications = hs.fnutils.filter(notifications, function(notification)
			--- Ignore read notifications
			if notification.unread == false then
				return true
			end

			--- If we haven't checked before, assume all are unread
			if not self.last_checked then
				return true
			end

			--- Compare the last time notifications were checked to when the
			--- notifications where last viewed on GitHub.
			return notification.last_read_at > self.last_checked
		end)

		self:update_count(#notifications)
	end, "ignoreLocalAndRemoteCache")
end

--- Get a setting value
--- @param key string
--- @param func fun(): any
local function get_setting(key, func)
	local value = hs.settings.get(key)
	if value ~= nil then
		return value
	end

	value = func()
	if value ~= nil then
		hs.settings.set(key, value)
	end

	return value
end

--- Get the GitHub token from the settings
--- @return string|nil
local function get_token()
	return get_setting("github_token", function()
		local button, token = hs.dialog.textPrompt("Enter GitHub Token", "", "", "Save", "Cancel")

		if button == "Save" and token ~= "" then
			return token
		end

		return nil
	end)
end

--- Delete the menu bar icon
function M:delete_menu()
	if self.menu then
		self.menu:delete()
		self.menu = nil
	end
end

function M:start()
	self.token = get_token()

	if self.menu then
		self.menu:returnToMenuBar()
	else
		--- @type hs.menubar|nil
		self.menu = hs.menubar.new(true, "GitHubNotifications")
		self.menu:setTooltip("GitHub Notifications")
		self.menu:setIcon(readIcon)
		self.menu:setClickCallback(function()
			self.last_checked = os.date("!%Y-%m-%dT%H:%M:%SZ")
			self:update_count(0)
			hs.urlevent.openURL("https://github.com/notifications?query=is%3Aunread")
		end)
	end

	self.timer = hs.timer.new(self.interval or 60, function()
		self:on_timer()
	end)

	self.timer:start()
	self.timer:fire()

	return self
end

function M:stop()
	if self.menu then
		self:delete_menu()
	end

	if self.timer then
		self.timer:stop()
	end

	return self
end

return M
