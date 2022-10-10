-- Disable continuation comments when using o/O. CR will still add the
-- comment leader.
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("disable_continuation_comments", {}),
	command = "set formatoptions-=c | set formatoptions-=o",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("auto_source_dotfiles", {}),
	pattern = "*/nvim/lua/core/*.lua",
	command = "source <afile>",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
	group = vim.api.nvim_create_augroup("tsconfig_jsonc", {}),
	pattern = "tsconfig*.json",
	command = "set ft=jsonc",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("markdown_spell_check", {}),
	pattern = "markdown",
	command = "setlocal spell spelllang=en_us",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
	group = vim.api.nvim_create_augroup("log_no_wrap", {}),
	pattern = "*.log",
	command = "setlocal nowrap",
})
