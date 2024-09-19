local M = {}

--- Metadata
M.name = "RestartBluetooth"
M.version = "1.0"
M.author = "Mark Skelton <mark@mskelton.dev>"
M.homepage = "https://github.com/mskelton/dotfiles"
M.license = "ISC - https://opensource.org/licenses/ISC"

--- Execute a shell command asynchronously
--- @param command string
--- @param args string[]
--- @param callback fun()|nil
local function execute_async(command, args, callback)
	hs.task.new(command, callback, args):start()
end

--- Get the icon for the menu bar
--- @return hs.image|nil
local function get_icon()
	--- @type hs.image|nil
	local icon =
		hs.image.imageFromPath(hs.configdir .. "/Spoons/RestartBluetooth.spoon/bluetooth.png")

	if icon == nil then
		return nil
	end

	return icon:setSize({ w = 20, h = 20 })
end

--- Hides or shows the menu bar icon based on the number of screens
function M:hide_or_show()
	if #hs.screen.allScreens() > 1 then
		self.menu:returnToMenuBar()
	else
		self.menu:removeFromMenuBar()
	end
end

function M:start()
	if self.menu then
		self.menu:returnToMenuBar()
	else
		--- @type hs.menubar|nil
		self.menu = hs.menubar.new(true, "RestartBluetooth")
		self.menu:setTooltip("Restart Bluetooth")
		self.menu:setIcon(get_icon())
		self.menu:setClickCallback(function()
			local bin = "/opt/homebrew/bin/blueutil"

			execute_async(bin, { "--power", "0" }, function()
				execute_async(bin, { "--power", "1" })
			end)
		end)
	end

	--- Hide or show the menu bar icon based on the number of screens
	self:hide_or_show()

	--- Watch for screen changes and re-evaluate if the icon should be shown
	self.screen_watcher = hs.screen.watcher
		.new(function()
			self:hide_or_show()
		end)
		:start()

	return self
end

function M:stop()
	if self.menu then
		self.menu:removeFromMenuBar()
	end

	if self.screen_watcher then
		self.screen_watcher:stop()
	end

	return self
end

return M
