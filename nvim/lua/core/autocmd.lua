local group = vim.api.nvim_create_augroup("PackerAutoCompile", {})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  pattern = "*/nvim/lua/modules/*.lua",
  command = "source <afile> | PackerCompile",
})
