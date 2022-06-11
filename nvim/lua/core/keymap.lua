function map(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

-- Normal mode
map('n', '<space>k', '<cmd>nohlsearch<cr>')
map('n', '<space>w', '<cmd>bdelete<cr>')
map('n', '<space>s', '<cmd>write<cr>')

-- Telescope
map('n', '<space>p', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<space>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<space>fb', '<cmd>Telescope buffers<cr>')
map('n', '<space>fw', '<cmd>Telescope git_branches<cr>')

-- File tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<space>r', '<cmd>NvimTreeRefresh<CR>')
map('n', '<space>n', '<cmd>NvimTreeFindFile<CR>')
