local g = vim.g
local o = vim.opt

--- Space is a much better leader key.
g.mapleader = " "

--- I've debated a lot about the clipboard. Accessing my system clipboard for
--- pasting is something I do all the time, so it does feel right to
o.clipboard = "unnamedplus"

--- Setting the color column to 81 feels wrong, but text can advanced up to and
--- including the 80th column. Only when it hits column 81 (now overlapping the
--- color column), should it be shown as an issue.
o.colorcolumn = "81"

--- Use a vertical bar cursor in the command line window
o.guicursor = o.guicursor + "c:ver25"

--- Show trailing spaces
o.list = true
o.listchars = { tab = "  ", trail = "·" }

--- Better split directions
o.splitright = true
o.splitbelow = true

--- Spell checking
o.spelllang = "en_us"
o.spelloptions = "camel,noplainbuffer"

--- I don't use the mouse often, in fact when I do it's often wrong. But
--- sometimes when you are in a meeting leaning back in your chair, just clicking
--- on a buffer is easier than leaning back into the keyboard. That said, I'm
--- really not a fan of the right-click popups.
o.mouse = "a"
o.mousem = "extend"

--- Relative line numbers
o.number = true
o.relativenumber = true

--- Hide the intro message
o.shortmess = o.shortmess + "atTI"

--- Use the same spacing for tabs and spaces. While more confusing perhaps which
--- is used, I never actually care which is used. Go uses tabs, Prettier uses
--- spaces. It's all 2 visual spaces though.
o.shiftwidth = 2
o.tabstop = 2

--- Fold by indent
o.foldmethod = "indent"
o.foldlevel = 20

--- Store more oldfiles in the shada file
o.shada = "!,'1000,<500,s10,h"

--- Limit total completions to 10 items
o.pumheight = 15

--- Highlight the cursor line
o.cursorline = true

--- Disable search highlighting by default. I enable this with an autocmd during
--- searches and then disable it again when the search is done.
o.hlsearch = false

--- More stable screen splitting
o.splitkeep = "screen"

--- Use ripgrep for grepping
o.grepprg = "rg --vimgrep"
o.grepformat = "%f:%l:%c:%m"

--- Netrw
--- g.netrw_banner = 0
--- g.netrw_keepdir = 0
--- g.netrw_localcopydircmd = "cp -r"
--- g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) -- use .gitignore

--- Trying out a taller cmdline to attempt to reduce "Press ENTER" prompts.
o.cmdheight = 2

--- Allow project-local config files
o.exrc = true

--- These don't need much explanation
o.completeopt = "menu,menuone,noselect"
o.confirm = true
o.expandtab = true
o.ignorecase = true
o.showbreak = "    "
o.signcolumn = "yes"
o.smartcase = true
o.termguicolors = true
o.undofile = true
o.updatetime = 100

--- Abbreviations
vim.cmd("ca <expr> %% expand('%:p:h')")
