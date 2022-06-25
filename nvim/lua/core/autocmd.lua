local packer = vim.api.nvim_create_augroup("PackerCompile", {})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = packer,
	pattern = "*/nvim/lua/modules/*.lua",
	command = "source <afile> | PackerCompile",
})
