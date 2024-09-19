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
	local icon = hs.image.imageFromPath(
		os.getenv("HOME") .. "/.hammerspoon/Spoons/GitHubNotifications.spoon/" .. filename
	)

	if icon == nil then
		return nil
	end

	return icon:setSize({ w = 16, h = 16 })
end

function M:start()
	--- Create or restore menu
	if self.menu then
		self.menu:returnToMenuBar()
	else
		--- @type hs.menubar|nil
		self.menu = hs.menubar.new(true, "GitHubNotifications")
		self.menu:setTooltip("GitHub Notifications")
		self.menu:setIcon(get_icon("github.png"))
		self.menu:setClickCallback(function()
			hs.urlevent.openURL("https://github.com/notifications?query=is%3Aunread")
		end)
	end

	return self
end

function M:stop()
	if self.menu then
		self.menu:removeFromMenuBar()
	end

	return self
end

return M
