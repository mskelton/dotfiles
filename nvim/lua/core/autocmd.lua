vim.cmd([[
  augroup mskelton
    au!
    au BufEnter * set formatoptions-=c | set formatoptions-=o
    au BufWritePost */nvim/lua/core/*.lua source <afile>
    au FileType markdown setlocal spell
  augroup END
]])
