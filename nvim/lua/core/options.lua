local o = vim.opt

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.signcolumn = 'yes'
o.relativenumber = true
o.number = true
o.termguicolors = true
o.undofile = true
o.ignorecase = true
o.smartcase = true

-- Show trailing whitespace, but keep tabs invisible
o.list = true
o.listchars = { tab = '  ', trail = '·' }

-- Global status line
o.laststatus = 3

o.mouse = 'a'
o.scrolloff = 4
o.sidescrolloff = 4
o.clipboard = 'unnamed'
o.confirm = true
o.shortmess = o.shortmess + 'I'
o.updatetime = 100
o.colorcolumn = '80'
o.completeopt = "menu,menuone,noselect"