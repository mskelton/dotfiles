function map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

vim.g.mapleader = ","

map("n", ";", ":", { silent = false })
-- map("n", "!", ":!", { silent = false })

map("n", "<leader>S", "<cmd>noa w<cr>")
map("n", "<leader>b", "<cmd>bp<cr>")
map("n", "<leader>f", "<cmd>bn<cr>")
map("n", "<leader>q", "<cmd>ccl<cr>")
map("n", "<leader>s", "<cmd>w<cr>")
map("n", "<leader>w", "<cmd>bd<cr>")

-- Deprecated
map("n", "<space>s", "<cmd>w<cr>")
map("n", "<space>w", "<cmd>bd<cr>")
map("n", "<space>p", "<cmd>Telescope find_files<cr>")
map("n", "<leader>g", "<cmd>Telescope live_grep<cr>")

-- Telescope
map("n", "<space>fs", "<cmd>Telescope live_grep<cr>")
map("n", "<space>ff", "<cmd>Telescope find_files<cr>")
map("n", "<space>fo", "<cmd>Telescope oldfiles<cr>")
map("n", "<space>fb", "<cmd>Telescope buffers<cr>")
map("n", "<space>fg", "<cmd>Telescope git_branches<cr>")

-- Hop
map("n", "<space>hl", "<cmd>HopLine<cr>")
map("n", "<space>hw", "<cmd>HopWord<cr>")
map("n", "<space>hc", "<cmd>HopChar1<cr>")
map("n", "<space>hC", "<cmd>HopChar2<cr>")

-- Packer
map("n", "<leader>ps", "<cmd>PackerSync<cr>")
map("n", "<leader>pc", function()
	require("packer").compile()
	print("Packer compiled successfully!")
end)
