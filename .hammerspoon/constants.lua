local M = {}

local utils = require("utils")

M.keys = {
	hyper = { "cmd", "option", "ctrl", "shift" },
	meh = { "ctrl", "option", "shift" },
	layer_key = { "cmd", "ctrl" },
}

M.browser = "Arc"

M.screens = {
	laptop = "Built-in Retina Display",
	primary = "LG ULTRAFINE",
	secondary = "LG Ultra HD",
}

M.disabled_apps = utils.if_work({
	"Postman",
}, {
	"Postman",
	"Slack",
	"Linear",
	"Zoom",
	"zoom.us",
})

return M
