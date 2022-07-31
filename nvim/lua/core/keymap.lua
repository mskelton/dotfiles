-- My approach to keymapping follows two important principles:
--
-- 1. Keybindings should be pneumonic when possible (e.g. pc - packer compile)
-- 2. The same finger should not be used twice in heavily used eybinding
--
-- The first principle is important for learnability of keybindings, especially
-- bindings that are less frequently used. For example, you can remember "fg"
-- easily as it means "find git branches".
--
-- The second principle is important for quickly executing common commands, and
-- sometimes this results in breaking the first principle. For example, "ff"
-- would be most ideal for "find files", however that motion is slower due to
-- the same finger being used twice in the keybinding. In these cases,
-- alternative keys can be used such as "fp" since cmd+p is a common shortcut in
-- other editors such as VS Code, so it still has meaning. This second principle
-- allows for more keybindings to be set while still keeping the speed of
-- executing each keybinging relatively stable and fast.

local function map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

map("n", ";", ":", { silent = false })

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

-- Hop
map("n", "<leader>hl", "<cmd>HopLine<cr>")
map("n", "<leader>ht", "<cmd>HopWordCurrentLine<cr>") -- "Hop This line"
map("n", "<leader>hw", "<cmd>HopWord<cr>")
map("n", "<leader>hc", "<cmd>HopChar1<cr>")
map("n", "<leader>hC", "<cmd>HopChar2<cr>")

-- Packer
map("n", "<leader>ps", "<cmd>PackerSync<cr>")
map("n", "<leader>pc", function()
	require("packer").compile()
	print("Packer compiled successfully!")
end)

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>")
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
-- map("n", "gR", "<cmd>Trouble lsp_references<cr>")

-- Deprecated keymappings
local function nop()
	print("This keybinding is now a nop")
end

map("n", "<leader>p", nop)
map("n", "<leader>s", nop)
map("n", "<leader>w", nop)
