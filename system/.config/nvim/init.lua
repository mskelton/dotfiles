--- Space is a much better leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- I've debated a lot about the clipboard. Accessing my system clipboard for
--- pasting is something I do all the time, so it does feel right to
vim.opt.clipboard = "unnamedplus"

--- Setting the color column to 81 feels wrong, but text can advanced up to and
--- including the 80th column. Only when it hits column 81 (now overlapping the
--- color column), should it be shown as an issue.
vim.opt.colorcolumn = "81"

--- Use a vertical bar cursor in the command line window
vim.opt.guicursor = vim.opt.guicursor + "c:ver25"

--- Show trailing spaces
vim.opt.list = true
vim.opt.listchars = "tab:  ,trail:·"

--- Better split directions
vim.opt.splitright = true
vim.opt.splitbelow = true

--- Spell checking
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel,noplainbuffer"

--- I don't use the mouse often, in fact when I do it's often wrong. But
--- sometimes when you are in a meeting leaning back in your chair, just clicking
--- on a buffer is easier than leaning back into the keyboard. That said, I'm
--- really not a fan of the right-click popups.
vim.opt.mouse = "a"
vim.opt.mousem = "extend"

--- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

--- Hide the intro message
vim.opt.shortmess = vim.opt.shortmess + "atTI"

--- Use the same spacing for tabs and spaces. While more confusing perhaps which
--- is used, I never actually care which is used. Go uses tabs, Prettier uses
--- spaces. It's all 2 visual spaces though.
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

--- Fold by indent
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 20

--- Store more oldfiles in the shada file
vim.opt.shada = "!,'1000,<500,s10,h"

--- Limit total completions to 10 items
vim.opt.pumheight = 15

--- Highlight the cursor line
vim.opt.cursorline = true

--- Disable search highlighting by default. I enable this with an autocmd during
--- searches and then disable it again when the search is done.
vim.opt.hlsearch = false

--- More stable screen splitting
vim.opt.splitkeep = "screen"

--- Use ripgrep for grepping
vim.opt.grepprg = "rg --vimgrep --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"

--- Netrw settings here if I ever care to experiment with Netrw again. I'm still
--- torn, I love it and hate it.
--- vim.g.netrw_banner = 0
--- vim.g.netrw_keepdir = 0
--- vim.g.netrw_localcopydircmd = "cp -r"
--- vim.g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) -- use .gitignore

--- Using a 2-line command window reduces the number of "Press ENTER or type"
--- prompts which is very helpful for staying focused.
vim.opt.cmdheight = 2

--- Allow project-local config files
vim.opt.exrc = true

--- Completion menu options
vim.opt.completeopt = "menu,menuone"

--- Prompt for confirmation rather than simply failing the operation
vim.opt.confirm = true

--- Use spaces for tabs
vim.opt.expandtab = true

--- The best combination of options when searching. Ignore case by default, but
--- if there are any uppercase characters in the search, then search case sensitive.
vim.opt.ignorecase = true
vim.opt.smartcase = true

--- Use a 4-space soft line-break
vim.opt.showbreak = "    "

--- Always show the sign column even if there are no errors to prevent layout
--- shifts when errors appear.
vim.opt.signcolumn = "yes"

--- Enable full terminal colors
vim.opt.termguicolors = true

--- Auto save undo history
vim.opt.undofile = true

--- TODO: Not sure if this is actually necessary, I need to dig more into this.
vim.opt.updatetime = 100

--- Default to replace all
vim.opt.gdefault = true

--- My approach to keymapping follows two important principles:
---
--- 1. Keybindings should be pneumonic
--- 2. The same finger should not be used twice in heavily used keybindings
---
--- The first principle is important for learn-ability of keybindings, especially
--- bindings that are less frequently used. For example, you can remember "fg"
--- easily as it means "Find Git branches".
---
--- The second principle is important for quickly executing common commands, and
--- sometimes this results in breaking the first principle. For example, "ff"
--- would be most ideal for "find files", however that motion is slower due to
--- the same finger being used twice in the keybinding. In these cases,
--- alternative keys can be used such as "fp" since cmd+p is a common shortcut in
--- other editors such as VS Code, so it still has meaning. This second principle
--- allows for more keybindings to be set while still keeping the speed of
--- executing each keybinding relatively stable and fast.

--- Most of my key mappings are applicable to both normal and visual mode
local nv = { "n", "v" }

--- Shiftless command mode. I've debated this one some since other tools with Vim
--- emulation don't use this, so it kind of makes life a little harder when
--- working between tools. That said, my goal is to use other tools as little as
--- possible, and tools like IntelliJ have good enough Vim emulation where it
--- allows replicating this functionality.
---
--- I've considered remapping colon to semicolon, but I often find myself
--- pressing shift before colon for commands like :Duplicate or :G as it's easier
--- do a chorded reach with the left hand then the alternative which would be
--- non-shift click of semicolon, then right-shift the uppercase letter.
vim.keymap.set(nv, ";", ":", { desc = "Enter command line" })

--- Map leader semicolon to the original semicolon motion to still allow using
--- (next f/t match) since that motion is quite handy. I don't use it much, so
--- the extra keypress is fine.
vim.keymap.set("n", "<leader>;", ";", { desc = "Next f/t match" })

--- Really common shortcuts
vim.keymap.set(nv, ",s", "<cmd>w ++p<cr>", { desc = "Save buffer" })
vim.keymap.set(nv, ",S", "<cmd>noa w<cr>", { desc = "Save buffer without autocmds" })
vim.keymap.set(nv, ",q", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set(nv, ",c", "<cmd>clo<cr>", { desc = "Close buffer" })

--- Close window or buffer
vim.keymap.set(nv, ",w", function()
	--- Auto-close the quickfix list if it's open
	if #vim.fn.getqflist() > 0 and vim.vim.opt.buftype ~= "quickfix" then
		vim.cmd("cclose")
	end

	--- Close the window if there are multiple windows open
	if vim.api.nvim_win_get_number(0) > 1 then
		vim.cmd("close")
	else
		vim.cmd("bdelete!")
	end
end, { desc = "Close window or buffer" })

--- Move lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line down" })

--- Join lines without losing your cursor position
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines" })

--- Paste commands
vim.keymap.set("n", "<leader>pa", 'ggVG"_dP', { desc = "Paste over entire file" })

--- I frequently roll zv for visually selection which doesn't work great on my
--- keyboard since I use a multi-function key for z/ctrl. This mapping sets
--- zv to the same as C-v.
vim.keymap.set("n", "zv", "<C-v>", { desc = "Start visual block selection" })

--- Modify j and k to navigate wrapped lines
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
