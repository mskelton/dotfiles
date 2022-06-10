function map(mode, key, cmd, opts)
  vim.api.nvim_set_keymap(mode, key, cmd, opts or { noremap = true, silent = true })
end

-- Leader key
vim.g.mapleader = ' '

-- Normal mode
map('n', '<leader>k', ':nohlsearch<cr>')
map('n', '<leader>w', ':bdelete<cr>')

-- Telescope
map('n', '<leader>p', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fw', '<cmd>Telescope git_branches<cr>')

-- File tree
map('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>r', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>n', '<cmd>NvimTreeFindFile<CR>')
