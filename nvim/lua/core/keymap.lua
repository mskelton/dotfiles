function map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

-- Backslash is a little tough to reach, so I use a comma instead. I would use
-- a semi colon, but that is not available since I remaped that for a shiftless
-- entry into command mode.
vim.g.mapleader = ","

-- Allow using semicolon to enter command mode. Don't make it silent so that we
-- can see when entering command mode.
map("n", ";", ":", { silent = false })

-- Normal mode
map("n", "<space>k", "<cmd>noh<cr>")
map("n", "<space>s", "<cmd>w<cr>")
map("n", "<space>w", "<cmd>bd<cr>")
map("n", "<leader>f", "<cmd>bn<cr>")
map("n", "<leader>b", "<cmd>bp<cr>")
map("n", "<leader>t", "<cmd>TSHighlightCapturesUnderCursor<cr>")

-- Packer compile
vim.keymap.set("n", "<leader>pc", function()
	require("packer").compile()
	print("Packer compiled successfully!")
end)

-- Telescope
map("n", "<space>p", "<cmd>Telescope find_files<cr>")
map("n", "<space>ff", "<cmd>Telescope oldfiles<cr>")
map("n", "<space>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<space>fb", "<cmd>Telescope buffers<cr>")
map("n", "<space>fw", "<cmd>Telescope git_branches<cr>")

-- File tree
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
