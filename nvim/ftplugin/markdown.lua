--- Enable spell checking in markdown
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

--- Hard wrapping in markdown
vim.opt_local.textwidth = 80
vim.opt_local.formatoptions:append("t")

vim.keymap.set("n", "<leader>pi", "<cmd>read !img --format md<cr>", {
	desc = "Paste image",
})
