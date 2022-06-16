local o = vim.opt

function map(mode, key, cmd, opts)
	vim.keymap.set(mode, key, cmd, opts or { silent = true })
end

-- o.backup = false
-- o.writebackup = false
-- o.swapfile = false
-- o.hlsearch = true
-- o.ignorecase = true
-- o.smartcase = true
-- o.virtualedit = "block"
-- o.clipboard = "unnamedplus"
-- o.iskeyword = o.iskeyword + "-"

-- Misc
map("n", "Y", "y$")

-- map('n', 'K', '<cmd>call VSCodeNotify("editor.action.showHover")<CR>')
-- map('n', '<space>gr', '<cmd>call VSCodeNotify("editor.action.goToReferences")<CR>')
-- map('n', '<space>qf', '<cmd>call VSCodeNotify("editor.action.quickFix")<CR>')
-- map('n', '<space>gd', '<cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>')
-- map('n', '<C-w>gd', '<cmd>call VSCodeNotify("editor.action.revealDefinitionAside")<CR>')

-- Buffers
map("n", "<space>s", '<cmd>call VSCodeNotify("workbench.action.files.save")<CR>')
map("n", "<space>w", '<cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>')
map("n", "<leader>b", '<cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>')
map("n", "<leader>f", '<cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>')

-- Commentary
-- map("x", "gc", "<Plug>VSCodeCommentary", { noremap = false })
-- map("n", "gc", "<Plug>VSCodeCommentary", { noremap = false })
-- map("o", "gc", "<Plug>VSCodeCommentary", { noremap = false })
-- map("n", "gcc", "<Plug>VSCodeCommentaryLine", { noremap = false })
