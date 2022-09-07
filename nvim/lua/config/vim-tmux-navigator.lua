return function()
	local map = require("core.utils").map

	vim.g.tmux_navigator_no_mappings = 1

	map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
	map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
	map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
	map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
end
