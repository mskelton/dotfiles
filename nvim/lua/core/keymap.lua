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

-- Most of my mappings are applicable to both normal and visual mode
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
map(nv, ";", ":", { silent = false })

-- Map leader semicolon to the original semicolon motion to still allow using
-- (next f/t match) since that motion is quite handy. I don't use it much, so
-- the extra keypress is fine.
map("n", "<leader>;", ";")

-- I use the command line window a fair bit, but it requires pressing q, then
-- shifting the left pinky to shift to press colon. This mapping makes it much
-- easier to enter the command line window.
map(nv, "<leader>q", "q:")

-- I never can find where my cursor is after jumping by half. This makes it a
-- bit easier.
map(nv, "<C-d>", "<cmd>lua MoveHalf(1)<cr>")
map(nv, "<C-u>", "<cmd>lua MoveHalf(-1)<cr>")

-- Really common shortcuts
map(nv, ",s", "<cmd>w<cr>")
map(nv, ",w", "<cmd>bd<cr>")
map(nv, ",c", "<cmd>clo<cr>")

-- Open netrw easily
map("n", "<leader>pv", vim.cmd.Ex)

-- Move lines up and down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")

-- Join lines without losing your cursor position
map("n", "J", "mzJ`z")

-- Paste without yanking
map("x", "<leader>p", '"_dP')

-- Modify j and k to navigate wrapped lines
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--------------------------------------------------------------------------------
--- TELESCOPE ------------------------------------------------------------------
--------------------------------------------------------------------------------
map(nv, "<leader>fp", "<cmd>Telescope find_files<cr>") -- Similar to cmd+p
map(nv, "<leader>fP", "<cmd>Telescope file_browser path=%:p:h<cr>") -- Similar to cmd+p
map(nv, "<leader>fs", "<cmd>Telescope live_grep regex=false<cr>") -- "Find exact String"
map(nv, "<leader>fS", "<cmd>Telescope live_grep<cr>") -- "Find regex String"
map(nv, "<leader>fo", "<cmd>Telescope oldfiles<cr>") -- "Find Old file"
map(nv, "<leader>fg", "<cmd>Telescope git_branches<cr>") -- "Find Git branches"
map(nv, "<leader>fl", "<cmd>Telescope resume<cr>") -- "Find Last"
map(nv, "<leader>fy", "<cmd>Telescope lsp_document_symbols<cr>") -- "Find sYmbols"
map(nv, "<leader>fY", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>") -- "Find workspace sYmbols"
map(nv, "<leader>fh", "<cmd>Telescope help_tags<cr>") -- "Find Help tags"
map(nv, "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
map(nv, "<leader>bl", "<cmd>Telescope buffers<cr>") -- "Buffer List"
map(nv, "z=", "<cmd>Telescope spell_suggest<cr>") -- Override default spell suggest

--------------------------------------------------------------------------------
--- WINDOW ---------------------------------------------------------------------
--------------------------------------------------------------------------------
map("n", "<leader>w=", "<C-w>=")
map("n", "<leader>w+", "<C-w>+")
map("n", "<leader>w-", "<C-w>-")
map("n", "<leader>w<", "<C-w><")
map("n", "<leader>w>", "<C-w>>")
map("n", "<leader>wh", "<C-w>H")
map("n", "<leader>wj", "<C-w>J")
map("n", "<leader>wk", "<C-w>K")
map("n", "<leader>wl", "<C-w>L")
map("n", "<leader>wo", "<C-w>o")
map("n", "<leader>wp", "<C-w>P")

--------------------------------------------------------------------------------
--- GIT (VCS) ------------------------------------------------------------------
--------------------------------------------------------------------------------
map(nv, "<leader>vo", "<cmd>LazyGit<cr>")
map(nv, "<leader>vb", "<cmd>Git blame<cr>")
map(nv, "<leader>vd", "<cmd>Gvdiffsplit<cr>")
map(nv, "<leader>vl", "<cmd>vertical Git log<cr>")
map(nv, "<leader>vp", "<cmd>Git push<cr>")
map(nv, "<leader>vP", "<cmd>Git pull<cr>")
map(nv, "<leader>vc", function()
	require("bandit").commit()
end)

-- -- Stage/reset individual hunks under cursor in a file
-- map("v", "<leader>vs", "<cmd>Gitsigns stage_hunk<cr>")
-- map("v", "<leader>vr", "<cmd>Gitsigns reset_hunk<cr>")
-- map("v", "<leader>vu", "<cmd>Gitsigns undo_stage_hunk<cr>")
--
-- -- Stage/reset all hunks in a file
-- map("n", "<leader>vs", "<cmd>Gitsigns stage_buffer<cr>")
-- map("n", "<leader>vu", "<cmd>Gitsigns reset_buffer_index<cr>")
-- map("n", "<leader>vr", "<cmd>Gitsigns reset_buffer<cr>")

-- WIP: This isn't working yet
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("diff_keymap", {}),
	pattern = "diff",
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }

		map("n", "gdh", "<cmd>diffget //2<cr>", opts)
		map("n", "gdl", "<cmd>diffget //3<cr>", opts)
	end,
})

--------------------------------------------------------------------------------
--- OPERATIONS -----------------------------------------------------------------
--------------------------------------------------------------------------------

-- Delete file
map("n", "<leader>odf", function()
	if vim.fn.confirm("Delete file?", "&Yes\n&No") == 1 then
		vim.cmd("Delete!")
	end
end)

-- Make file executable
map(
	"n",
	"<leader>ox",
	"<cmd>Chmod +x % | echo 'File permissions set to executable'<cr>"
)

-- Packer sync
map("n", "<leader>ops", function()
	vim.cmd("luafile ~/.config/nvim/lua/plugins.lua")
	require("packer").sync()
end)

-- Packer compile
map("n", "<leader>opc", function()
	vim.cmd("luafile ~/.config/nvim/lua/plugins.lua")
	require("packer").compile()
	print("Packer compiled successfully!")
end)

--------------------------------------------------------------------------------
--- TEXT OBJECTS ---------------------------------------------------------------
--------------------------------------------------------------------------------

-- "entire" text object
map("v", "ae", ":<C-U>silent! normal! ggVG<cr>", { silent = false })
map("o", "ae", "<cmd>normal Vae<cr>", { remap = true })

-- remap "sentence" text object to capital S since I use lowercase s for statement
map({ "v", "o" }, "aS", "as")
map({ "v", "o" }, "iS", "is")
