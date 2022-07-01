vim.cmd([[
  augroup PackerCompile
    au!
    au BufWritePost */nvim/lua/modules/*.lua source <afile> | PackerCompile
  augroup END 

  augroup FormatOptions
    au!
    au BufEnter * set formatoptions-=co
  augroup END 
]])
