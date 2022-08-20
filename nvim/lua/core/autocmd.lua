vim.cmd([[
  " augroup PackerCompile
  "   au!
  "   au BufWritePost */nvim/lua/plugins.lua,*/nvim/lua/config/*.lua source <afile> | PackerCompile
  " augroup END 

  augroup FormatOptions
    au!
    au BufEnter * set formatoptions-=c | set formatoptions-=o
  augroup END 
]])
