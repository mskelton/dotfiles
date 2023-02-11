-- My approach to keymapping follows two important principles:
--
-- 1. Keybindings should be pneumonic
-- 2. The same finger should not be used twice in heavily used keybindings
--
-- The first principle is important for learn-ability of keybindings, especially
-- bindings that are less frequently used. For example, you can remember "fg"
-- easily as it means "Find Git branches".
--
-- The second principle is important for quickly executing common commands, and
-- sometimes this results in breaking the first principle. For example, "ff"
-- would be most ideal for "find files", however that motion is slower due to
-- the same finger being used twice in the keybinding. In these cases,
-- alternative keys can be used such as "fp" since cmd+p is a common shortcut in
-- other editors such as VS Code, so it still has meaning. This second principle
-- allows for more keybindings to be set while still keeping the speed of
-- executing each keybinding relatively stable and fast.
local map = require("core.utils").map

-- Most of my key mappings are applicable to both normal and visual mode
local nv = { "n", "v" }

-- Shiftless command mode. I've debated this one some since other tools with Vim
-- emulation don't use this, so it kind of makes life a little harder when
-- working between tools. That said, my goal is to use other tools as little as
-- possible, and tools like IntelliJ have good enough Vim emulation where it
-- allows replicating this functionality.
--
-- I've considered remapping colon to semicolon, but I often find myself
-- pressing shift before colon for commands like :Duplicate or :G as it's easier
-- do a chorded reach with the left hand then the alternative which would be
-- non-shift click of semicolon, then right-shift the uppercase letter.
map(nv, ";", ":", { silent = false, desc = "Enter command line" })

-- Map leader semicolon to the original semicolon motion to still allow using
-- (next f/t match) since that motion is quite handy. I don't use it much, so
-- the extra keypress is fine.
map("n", "<leader>;", ";", "Next f/t match")

-- I use the command line window a fair bit, but it requires pressing q, then
-- shifting the left pinky to shift to press colon. This mapping makes it much
-- easier to enter the command line window.
map(nv, "<leader>q", "q:", "Open command line window")

-- I never can find where my cursor is after jumping by half. This makes it a
-- bit easier.
map(nv, "<C-d>", "<cmd>lua MoveHalf(1)<cr>", "Scroll down half screen")
map(nv, "<C-u>", "<cmd>lua MoveHalf(-1)<cr>", "Scroll up half screen")

-- Really common shortcuts
map(nv, ",s", "<cmd>w<cr>", "Save buffer")
map(nv, ",w", "<cmd>bd<cr>", "Delete buffer")
map(nv, ",c", "<cmd>clo<cr>", "Close buffer")

-- Move lines up and down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", "Move line up")
map("v", "K", ":m '<-2<cr>gv=gv", "Move line down")

-- Join lines without losing your cursor position
map("n", "J", "mzJ`z", "Join lines")

-- Paste without yanking
map("x", "<leader>p", '"_dP', "Paste without yanking")

-- I frequently roll zv for visually selection which doesn't work great on my
-- keyboard since I use a multi-function key for z/ctrl. This mapping sets
-- zv to the same as C-v.
map("n", "zv", "<C-v>", "Start visual block selection")

-- Modify j and k to navigate wrapped lines
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

map("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {
	silent = false,
	desc = "Rename the word under the cursor",
})

map(
	"n",
	"gx",
	':silent! !echo "<c-r><c-a>" | url | xargs open<cr>',
	"Open URL under cursor"
)
-- map(
-- 	"v",
-- 	"gx",
-- 	[[:'<,'>silent! !echo "<c-r>*" | url | xargs open<cr>]],
-- 	"Open the URL in the selection"
-- )

--------------------------------------------------------------------------------
--- WINDOW ---------------------------------------------------------------------
--------------------------------------------------------------------------------
map("n", "<leader>w=", "<C-w>=", "Resize windows equally")
map("n", "<leader>w+", "<C-w>+", "Increase window height")
map("n", "<leader>w-", "<C-w>-", "Decrease window height")
map("n", "<leader>w>", "<C-w>>", "Increase window width")
map("n", "<leader>w<", "<C-w><", "Decrease window width")
map("n", "<leader>wh", "<C-w>H", "Move current window to the far left")
map("n", "<leader>wl", "<C-w>L", "Move current window to the far right")
map("n", "<leader>wk", "<C-w>K", "Move current window to the very top")
map("n", "<leader>wj", "<C-w>J", "Move current window to the very bottom")
map("n", "<leader>wo", "<C-w>o", "Make current window the only window")
map("n", "<leader>wp", "<C-w>P", "Go to previous window")

--------------------------------------------------------------------------------
--- GIT (VCS) ------------------------------------------------------------------
--------------------------------------------------------------------------------
map(nv, "<leader>vb", "<cmd>Git blame<cr>", "Git blame")
map(nv, "<leader>vd", "<cmd>Gvdiffsplit<cr>", "Git diff")
map(nv, "<leader>vl", "<cmd>vertical Git log<cr>", "Git log")
map(nv, "<leader>vp", "<cmd>Git push<cr>", "Git push")
map(nv, "<leader>vP", "<cmd>Git pull<cr>", "Git pull")

-- Stage/reset individual hunks under cursor in a file
map("v", "<leader>vs", "<cmd>Gitsigns stage_hunk<cr>", "Git: stage hunk")
map("v", "<leader>vr", "<cmd>Gitsigns reset_hunk<cr>", "Git: reset hunk")

--------------------------------------------------------------------------------
--- OPERATIONS -----------------------------------------------------------------
--------------------------------------------------------------------------------

map("n", "<leader>odf", function()
	if vim.fn.confirm("Delete file?", "&Yes\n&No") == 1 then
		vim.cmd("Delete!")
	end
end, "Delete file")

map(
	"n",
	"<leader>ox",
	"<cmd>Chmod +x % | echo 'File permissions set to executable'<cr>",
	"Make file executable"
)

--------------------------------------------------------------------------------
--- TEXT OBJECTS ---------------------------------------------------------------
--------------------------------------------------------------------------------

-- "entire" text object
map("v", "ae", ":<C-U>silent! normal! ggVG<cr>", {
	silent = false,
	desc = "Entire buffer",
})
map("o", "ae", "<cmd>normal Vae<cr>", {
	remap = true,
	desc = "Entire buffer",
})

-- remap "sentence" text object to capital S since I use lowercase s for statement
map({ "v", "o" }, "aS", "as", "Sentence")
map({ "v", "o" }, "iS", "is", "Sentence")
