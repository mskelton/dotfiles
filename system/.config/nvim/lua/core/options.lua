--- @vs-reviewed
local g = vim.g
local o = vim.opt

--- Space is a much better leader key.
g.mapleader = " "
g.maplocalleader = " "

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
o.listchars = require("core.utils.trailer").standard

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
o.grepprg = "rg --vimgrep --hidden"
o.grepformat = "%f:%l:%c:%m"

--- Netrw settings here if I ever care to experiment with Netrw again. I'm still
--- torn, I love it and hate it.
--- g.netrw_banner = 0
--- g.netrw_keepdir = 0
--- g.netrw_localcopydircmd = "cp -r"
--- g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) -- use .gitignore

--- Using a 2-line command window reduces the number of "Press ENTER or type"
--- prompts which is very helpful for staying focused.
o.cmdheight = 2

--- Allow project-local config files
o.exrc = true

--- Completion menu options
o.completeopt = "menu,menuone"

--- Prompt for confirmation rather than simply failing the operation
o.confirm = true

--- Use spaces for tabs
o.expandtab = true

--- The best combination of options when searching. Ignore case by default, but
--- if there are any uppercase characters in the search, then search case sensitive.
o.ignorecase = true
o.smartcase = true

--- Use a 4-space soft line-break
o.showbreak = "    "

--- Always show the sign column even if there are no errors to prevent layout
--- shifts when errors appear.
o.signcolumn = "yes"

--- Enable full terminal colors
o.termguicolors = true

--- Auto save undo history
o.undofile = true

--- TODO: Not sure if this is actually necessary, I need to dig more into this.
o.updatetime = 100

--- Default to replace all
o.gdefault = true
