local M = {}

local utils = require("utils")

M.window_padding = 12

M.keys = {
	hyper = { "cmd", "alt", "ctrl", "shift" },
	meh = { "ctrl", "alt", "shift" },
	layer_key = { "cmd", "ctrl" },
}

M.screens = {
	laptop = "Built-in Retina Display",
	primary = "LG ULTRAFINE",
	secondary = "LG Ultra HD",
}

M.disabled_apps = utils.if_work({ "Mimestream" }, {
	"Slack",
	"Linear",
	"zoom.us",
})

return M
