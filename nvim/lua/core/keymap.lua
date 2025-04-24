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
local map_fn = require("core.utils").map_fn

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

--- This one is a bit of a hack. I use q; to open the command line window, but
--- that would normally prevent `q` from immediately stopping macro recordings
--- since it would be waiting for the next character. This mapping is conditional
--- to only be active when not recording a macro.
local command_line = map_fn(nv, "q;", "q:", "Open command line window"):set()

require("core.utils").augroup("mskelton_command_line", function(autocmd)
	autocmd("RecordingEnter", { callback = command_line.del })
	autocmd("RecordingLeave", { callback = command_line.set })
end)

--- Map leader semicolon to the original semicolon motion to still allow using
--- (next f/t match) since that motion is quite handy. I don't use it much, so
--- the extra keypress is fine.
map("n", "<leader>;", ";", "Next f/t match")

--- I use the command line window a fair bit, but it requires pressing q, then
--- shifting the left pinky to shift to press colon. This mapping makes it much
--- easier to enter the command line window.
map(nv, "<leader>q", "q:", "Open command line window")

--- I never can find where my cursor is after jumping by half. This makes it a
--- bit easier.
map(nv, "<C-d>", "<cmd>lua MoveHalf(1)<cr>", "Scroll down half screen")
map(nv, "<C-u>", "<cmd>lua MoveHalf(-1)<cr>", "Scroll up half screen")

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

--- Rename the word under the cursor
map("n", "<leader>rw", function()
	local value = vim.fn.expand("<cWORD>")

	vim.ui.input({
		prompt = "Rename word",
		default = value,
	}, function(new_value)
		vim.cmd("%s/" .. value .. "/" .. new_value .. "/gI")
	end)
end, {
	silent = false,
	desc = "Rename the word under the cursor",
})

--- Find the word under cursor in the project
map("n", "gw", ":silent! grep <C-r><C-w> | copen<cr>", {
	desc = "Go to word under cursor",
})

--- Open help to last location. Sadly due to some issues I don't understand,
--- opening help immediately requires wrapping it in `vim.schedule`.
map("n", "<leader>oh", function()
	vim.schedule(function()
		vim.cmd("help | only | normal 'H")
	end)
end, "Reopen help")

--- Close other buffers. Like :only but for buffers.
map("n", "<leader>on", function()
	local current_buffer = vim.fn.bufnr("%")

	for _, buffer in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if buffer.bufnr ~= current_buffer then
			vim.api.nvim_buf_delete(buffer.bufnr, {})
		end
	end

	--- Bufferline doesn't refresh automatically, so we have to manually refresh it
	require("core.utils").safe_require("bufferline.ui", function(ui)
		ui.refresh()
	end)
end, "Close other buffers")

--- Open URLs under the cursor
map("n", "gx", function()
	require("core.utils").open_url(vim.fn.expand("<cWORD>"))
end, "Open URL under cursor")

--- Open URLs in visual selection
map("v", "gx", [[:'<,'>w <Home>silent<End> !url | xargs open<cr>]], {
	desc = "Open URL in selection",
})

--- Sort inner indent
map("n", "<leader>si", "!ii<bs>sort<cr>", {
	desc = "Sort inner indent",
	remap = true,
})

--- Copy file path to clipboard
map(
	nv,
	"<leader>cp",
	"<cmd>CopyPath | echo 'File path copied to clipboard!'<cr>",
	"Copy file path to clipboard"
)

--- Open man page for word under cursor
map(nv, "<leader>k", "<cmd>Man<cr>", "Open man page")

--- TODO use this mapping
--- I don't use = for indenting lines, I use auto formatters for that.
--- map(nv, "=", "", { desc = "", nowait = true })

map("n", "<leader>lw", "<cmd>Likewise<cr>", {
	silent = false,
	desc = "Likewise",
})

map(nv, "<leader>tp", "<cmd>InspectTree<cr>", {
	silent = false,
	desc = "Open TreeSitter playground",
})

--------------------------------------------------------------------------------
--- WINDOW ---------------------------------------------------------------------
--------------------------------------------------------------------------------
map("n", "<leader>w=", "<C-w>=", "Resize windows equally")
map("n", "<leader>wh", "<C-w>H", "Move current window to the far left")
map("n", "<leader>wl", "<C-w>L", "Move current window to the far right")
map("n", "<leader>wk", "<C-w>K", "Move current window to the very top")
map("n", "<leader>wj", "<C-w>J", "Move current window to the very bottom")
map("n", "<leader>wo", "<C-w>o", "Make current window the only window")
map("n", "<leader>wp", "<C-w>p", "Go to previous window")

--------------------------------------------------------------------------------
--- Tmux ---------------------------------------------------------------------
--------------------------------------------------------------------------------
map(
	"n",
	"<leader>ts",
	"<cmd>silent! !std<cr>",
	"Tmux: Sync session working directory"
)
map(
	"n",
	"<leader>tl",
	"<cmd>silent! !tmux resize-pane -y '80\\%' -t:.1<cr>",
	"Tmux: Show app logs"
)
map(
	"n",
	"<leader>tt",
	"<cmd>silent! !tmux resize-pane -y '80\\%' -t:.2<cr>",
	"Tmux: Show test terminal"
)

-------------------------------------------------------------------------------
--- OPERATIONS -----------------------------------------------------------------
--------------------------------------------------------------------------------

map("n", "<leader>od", function()
	if vim.fn.confirm("Delete file?", "&Yes\n&No") == 1 then
		vim.cmd("Delete!")
	end
end, "Delete file")

map("n", "<leader>of", function()
	os.execute('open "' .. vim.fn.expand("%:p:h") .. '"')
end, "Open file in finder")

map(
	"n",
	"<leader>ox",
	"<cmd>Chmod +x % | echo 'File permissions set to executable'<cr>",
	"Make file executable"
)

map(
	"n",
	"<leader>or",
	"<cmd>s/props/{ ...props }/<cr>",
	"Replace props with spread props"
)

map("n", "<leader>df", "<cmd>set foldlevel=20<cr>", "Disable folding")

map(
	"n",
	"<leader>uc",
	[[<cmd>0s/.*/"use client"\r\r&<cr>]],
	'Add "use client" directive to file'
)

local wrapper = require("core.utils.wrapper")
local test_query = [[
  (call_expression
    function: (identifier) @_name (#match? @_name "^(x?it|test|.*Test)$")) @test
]]

map("n", "<leader>wd", function()
	wrapper.wrap({
		lang = "typescript",
		query = test_query,
		capture_name = "test",
		before = "test.describe(() => {",
		after = "})",
		indent = true,
	})
end, "Wrap test in describe")

map("n", "<leader>wu", function()
	wrapper.wrap({
		lang = "typescript",
		query = test_query,
		capture_name = "test",
		before = {
			"test.describe(() => {",
			wrapper.indent("test.use({ })"),
			"",
		},
		after = "})",
		indent = true,
	})
end, "Wrap test in describe/use")
