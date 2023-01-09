--- The type defs for options are buggy
--- @diagnostic disable: assign-type-mismatch

local g = vim.g
local o = vim.opt

g.mapleader = " "

-- I've debated a lot about the clipboard. Accessing my system clipboard for
-- pasting is something I do all the time, so it does feel right to
o.clipboard = "unnamedplus"

-- Setting the color column to 81 feels wrong, but text can advanced up to and
-- including the 80th column. Only when it hits column 81 (now overlapping the
-- color column), should it be shown as an issue.
o.colorcolumn = "81"

-- Use a vertical bar cursor in the command line window
o.guicursor = o.guicursor + "c:ver25"

-- Show trailing spaces
o.list = true
o.listchars = { tab = "  ", trail = "·" }

-- Better split directions
o.splitright = true
o.splitbelow = true

-- Spell checking
o.spelllang = "en_us"
o.spelloptions = "camel,noplainbuffer"

-- I don't use the mouse often, in fact when I do it's often wrong. But
-- sometimes when you are in a meeting leaning back in your chair, just clicking
-- on a buffer is easier than leaning back into the keyboard. That said, I'm
-- really not a fan of the right-click popups.
o.mouse = "a"
o.mousem = "extend"

-- Relative line numbers
o.number = true
o.relativenumber = true

-- Hide the intro message
o.shortmess = o.shortmess + "I"

-- Use the same spacing for tabs and spaces. While more confusing perhaps which
-- is used, I never actually care which is used. Go uses tabs, Prettier uses
-- spaces. It's all 2 visual spaces though.
o.shiftwidth = 2
o.tabstop = 2

-- Use tree-sitter for folds
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 20

-- These don't need much explanation
o.completeopt = "menu,menuone,noselect"
o.confirm = true
o.cursorline = true
o.expandtab = true
o.hlsearch = false
o.ignorecase = true
o.showbreak = "    "
o.signcolumn = "yes"
o.smartcase = true
o.termguicolors = true
o.undofile = true
o.updatetime = 100

-- Abbreviations
vim.cmd("ca <expr> %% expand('%:p:h')")

-- Netrw
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_keepdir = 0
g.netrw_localcopydircmd = "cp -r"
