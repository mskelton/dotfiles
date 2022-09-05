local M = {}

M.nnoremap = function(key, cmd, opts)
	vim.keymap.set("n", key, cmd, opts or { silent = true })
end

M.onoremap = function(key, cmd, opts)
	vim.keymap.set("n", key, cmd, opts or { silent = true })
end

return M
