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
local map = require("core.utils").map

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
map(nv, ";", ":", { silent = false, desc = "Enter command line" })

--- Map leader semicolon to the original semicolon motion to still allow using
--- (next f/t match) since that motion is quite handy. I don't use it much, so
--- the extra keypress is fine.
map("n", "<leader>;", ";", "Next f/t match")

--- Really common shortcuts
map(nv, ",s", "<cmd>w ++p<cr>", "Save buffer")
map(nv, ",S", "<cmd>noa w<cr>", "Save buffer without autocmds")
map(nv, ",q", "<cmd>qa<cr>", "Quit all")
map(nv, ",c", "<cmd>clo<cr>", "Close buffer")

--- Close window or buffer
map(nv, ",w", function()
	--- Auto-close the quickfix list if it's open
	if #vim.fn.getqflist() > 0 and vim.o.buftype ~= "quickfix" then
		vim.cmd("cclose")
	end

	--- Close the window if there are multiple windows open
	if vim.api.nvim_win_get_number(0) > 1 then
		vim.cmd("close")
	else
		vim.cmd("bdelete!")
	end
end, "Close window or buffer")

--- Move lines up and down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", "Move line up")
map("v", "K", ":m '<-2<cr>gv=gv", "Move line down")

--- Join lines without losing your cursor position
map("n", "J", "mzJ`z", "Join lines")

--- Paste commands
map("n", "<leader>pa", 'ggVG"_dP', "Paste over entire file")

--- I frequently roll zv for visually selection which doesn't work great on my
--- keyboard since I use a multi-function key for z/ctrl. This mapping sets
--- zv to the same as C-v.
map("n", "zv", "<C-v>", "Start visual block selection")

--- Modify j and k to navigate wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
