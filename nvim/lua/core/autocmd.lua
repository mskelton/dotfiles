vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*/nvim/lua/modules/*.lua",
  command = "source <afile> | PackerCompile",
})
