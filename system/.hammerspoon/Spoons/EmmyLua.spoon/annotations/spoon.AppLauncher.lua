--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Simple spoon for launching apps with single letter hotkeys.
--
-- Example configuration using SpoonInstall.spoon:
-- ```
-- spoon.SpoonInstall:andUse("AppLauncher", {
--   hotkeys = {
--     c = "Calendar",
--     d = "Discord",
--     f = "Firefox Developer Edition",
--     n = "Notes",
--     p = "1Password 7",
--     r = "Reeder",
--     t = "Kitty",
--     z = "Zoom.us",
--   }
-- })
-- ```
--
-- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/AppLauncher.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/AppLauncher.spoon.zip)
---@class spoon.AppLauncher
local M = {}
spoon.AppLauncher = M

-- Binds hotkeys for AppLauncher
--
-- Parameters:
--  * mapping - A table containing single characters with their associated app
function M:bindHotkeys(mapping, ...) end

-- Modifier keys used when launching apps
--
-- Default value: `{"ctrl", "alt"}`
M.modifiers = nil

