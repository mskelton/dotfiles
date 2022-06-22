function map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

-- Allow using semicolon to enter command mode
map("n", ";", ":")

-- Normal mode
map("n", "<space>k", "<cmd>noh<cr>")
map("n", "<space>s", "<cmd>w<cr>")
map("n", "<space>w", "<cmd>bd<cr>")
map("n", "<leader>f", "<cmd>bn<cr>")
map("n", "<leader>b", "<cmd>bp<cr>")
map("n", "<leader>t", "<cmd>TSHighlightCapturesUnderCursor<cr>")

-- Telescope
map("n", "<space>p", "<cmd>Telescope find_files hidden=true<cr>")
map("n", "<space>ff", "<cmd>Telescope frecency<cr>")
map("n", "<space>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<space>fb", "<cmd>Telescope buffers<cr>")
map("n", "<space>fw", "<cmd>Telescope git_branches<cr>")

-- File tree
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
