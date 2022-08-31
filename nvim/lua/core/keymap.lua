-- My approach to keymapping follows two important principles:
--
-- 1. Keybindings should be pneumonic
-- 2. The same finger should not be used twice in heavily used keybindings
--
-- The first principle is important for learnability of keybindings, especially
-- bindings that are less frequently used. For example, you can remember "fg"
-- easily as it means "Find Git branches".
--
-- The second principle is important for quickly executing common commands, and
-- sometimes this results in breaking the first principle. For example, "ff"
-- would be most ideal for "find files", however that motion is slower due to
-- the same finger being used twice in the keybinding. In these cases,
-- alternative keys can be used such as "fp" since cmd+p is a common shortcut in
-- other editors such as VS Code, so it still has meaning. This second principle
-- allows for more keybindings to be set while still keeping the speed of
-- executing each keybinging relatively stable and fast.
local map = require("core.utils").map

-- Shiftless command mode
map("n", ";", ":", { silent = false })

-- Really common shortcuts
map("n", ",s", "<cmd>w<cr>")
map("n", ",w", "<cmd>bd<cr>")

-- Buffers
map("n", "<leader>bp", "<cmd>bp<cr>")
map("n", "<leader>bn", "<cmd>bn<cr>")
map("n", "<leader>bd", "<cmd>bd<cr>")
map("n", "<leader>bl", "<cmd>Telescope buffers<cr>") -- "Buffer List"

-- Find ...
map("n", "<leader>fp", "<cmd>Telescope find_files<cr>") -- Similar to cmd+p
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- "Find String"
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>") -- "Find Old file"
map("n", "<leader>fl", "<cmd>Telescope resume<cr>") -- "Find Last"
map("n", "<leader>fy", "<cmd>Telescope lsp_document_symbols<cr>") -- "Find sYmbols"
map("n", "<leader>fg", "<cmd>Telescope git_branches<cr>") -- "Find Git branches"
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- "Find Git branches"

-- Jump ...
map("n", "<leader>jl", "<cmd>HopLine<cr>")
map("n", "<leader>jt", "<cmd>HopWordCurrentLine<cr>") -- "Jump on This line"
map("n", "<leader>jw", "<cmd>HopWord<cr>")
map("n", "<leader>jc", "<cmd>HopChar1<cr>")
map("n", "<leader>jC", "<cmd>HopChar2<cr>")

-- Packer
map("n", "<leader>ps", function()
	vim.cmd("luafile ~/.config/nvim/lua/core/plugins.lua")
	require("packer").sync()
end)

map("n", "<leader>pc", function()
	require("packer").compile()
	print("Packer compiled successfully!")
end)

-- Trouble
map("n", "<leader>to", "<cmd>Trouble<cr>")
map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>tl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>")
map("n", "gR", "<cmd>Trouble lsp_references<cr>")

-- TODO: Remove
local noop = "<cmd>echo 'This key is a noop'<cr>"
map("n", ",b", noop)
map("n", ",f", noop)
