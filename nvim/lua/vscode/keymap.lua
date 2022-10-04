-- Simplified keymap for VS Code
local map = require("core.utils").map

map("n", ";", ":", { silent = false })
map("v", ";", ":", { silent = false })
map("n", "<leader>;", ";")

-- Really common shortcuts
map("n", ",s", "<cmd>W<cr>")
map("n", ",w", "<cmd>bd<cr>")

-- Buffers
map("n", "<leader>bp", "<cmd>bp<cr>")
map("n", "<leader>bn", "<cmd>bn<cr>")
map("n", "<leader>bd", "<cmd>bd<cr>")
map("n", "<leader>bl", "<cmd>Telescope buffers<cr>") -- "Buffer List"

-- Find ...
map("n", "<leader>fp", "<cmd>Telescope find_files<cr>") -- Similar to cmd+p
map("n", "<leader>fP", "<cmd>Telescope file_browser path=%:p:h<cr>") -- Similar to cmd+p
map("n", "<leader>fs", "<cmd>Telescope live_grep regex=false<cr>") -- "Find exact String"
map("n", "<leader>fS", "<cmd>Telescope live_grep<cr>") -- "Find regex String"
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>") -- "Find Old file"
map("n", "<leader>fg", "<cmd>Telescope git_branches<cr>") -- "Find Git branches"
map("n", "<leader>fl", "<cmd>Telescope resume<cr>") -- "Find Last"
map("n", "<leader>fy", "<cmd>Telescope lsp_document_symbols<cr>") -- "Find sYmbols"
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- "Find Help tags"
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

-- "entire" text object
map("v", "ae", ":<C-U>silent! normal! ggVG<cr>", { silent = false })
map("o", "ae", "<cmd>normal Vae<cr>", { remap = true })

-- remap "sentence" text object to capital S since I use lowercase s for statement
map("v", "aS", "as")
map("v", "iS", "is")
map("o", "aS", "as")
map("o", "iS", "is")
