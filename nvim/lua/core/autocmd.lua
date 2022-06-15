local packer = vim.api.nvim_create_augroup("PackerCompile", {})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = packer,
	pattern = "*/nvim/lua/modules/*.lua",
	command = "source <afile> | PackerCompile",
})

local kitty = vim.api.nvim_create_augroup("KittyWindow", {})

vim.api.nvim_create_autocmd("VimEnter", {
	group = kitty,
	pattern = "*",
	command = ":silent !kitty @ set-spacing padding=0",
})

vim.api.nvim_create_autocmd("VimLeave", {
	group = kitty,
	pattern = "*",
	command = ":silent !kitty @ set-spacing padding=15",
})
