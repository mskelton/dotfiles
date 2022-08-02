local g = vim.g
local o = vim.opt

g.do_filetype_lua = 1
g.mapleader = " "

o.clipboard = "unnamedplus"
o.colorcolumn = "81"
o.completeopt = "menu,menuone,noselect"
o.confirm = true
o.cursorline = true
o.expandtab = true
o.guicursor = o.guicursor + "c:ver25"
o.hlsearch = false
o.ignorecase = true
o.list = true
o.listchars = { tab = "  ", trail = "·" }
o.mouse = "a"
o.number = true
o.relativenumber = true
o.shiftwidth = 2
o.shortmess = o.shortmess + "I"
o.signcolumn = "yes"
o.smartcase = true
o.tabstop = 2
o.termguicolors = true
o.undofile = true
o.updatetime = 100
o.path = "**"

-- Abbreviations
vim.cmd("ca <expr> %% expand('%:p:h')")
