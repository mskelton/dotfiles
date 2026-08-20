--- Enable spell checking in markdown
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

--- Hard wrapping in markdown. Don't do this for Graphite PR descriptions.
if vim.fn.expand("%:t") ~= "GRAPHITE_PR_DESCRIPTION.md" then
	vim.opt_local.textwidth = 80
	vim.opt_local.formatoptions:append("t")
end

vim.keymap.set("n", "<leader>pi", "<cmd>read !img --format md<cr>", {
	desc = "Paste image",
})
