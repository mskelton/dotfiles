local g = vim.g
local o = vim.opt

-- Lua filetype detection
g.do_filetype_lua = 1

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.signcolumn = "yes"
o.relativenumber = true
o.number = true
o.termguicolors = true
o.undofile = true
o.ignorecase = true
o.smartcase = true

-- Show trailing whitespace, but keep tabs invisible
o.list = true
o.listchars = { tab = "  ", trail = "·" }

o.mouse = "a"
o.clipboard = "unnamed"
o.confirm = true
o.shortmess = o.shortmess + "I"
o.updatetime = 100
o.colorcolumn = "81"
o.completeopt = "menu,menuone,noselect"
o.hlsearch = false
o.cursorline = true
-- o.guicursor = o.guicursor + "c:ver25"

-- Abbreviations
vim.cmd([[
  ia fn function
  ca <expr> %% expand('%:p:h')
]])
