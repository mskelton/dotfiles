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
	local icon = hs.image.imageFromPath(
		os.getenv("HOME") .. "/.hammerspoon/Spoons/RestartBluetooth.spoon/bluetooth.png"
	)

	if icon == nil then
		return nil
	end

	return icon:setSize({ w = 20, h = 20 })
end

function M:start()
	--- Create or restore menu
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

	return self
end

function M:stop()
	if self.menu then
		self.menu:removeFromMenuBar()
	end

	return self
end

return M
