local utils = require("utils")

local M = {
	arc = "Arc",
	chat_gpt = "ChatGPT",
	figma = "Figma",
	finder = "Finder",
	kitty = "kitty",
	linear = "Linear",
	mimestream = "Mimestream",
	slack = "Slack",
	telegram = "Telegram",
	zoom = "zoom.us",
}

M.categories = {
	browser = M.arc,
	terminal = M.kitty,
	messaging = utils.if_work(M.slack, M.telegram),
	email = utils.if_work(nil, "Mimestream"),
	tasks = utils.if_work("Linear", "Todoist"),
}

return M
