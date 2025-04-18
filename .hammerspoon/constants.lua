local M = {}

local utils = require("utils")

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
	"Linear",
	"Notion",
	"Slack",
	"zoom.us",
})

return M
