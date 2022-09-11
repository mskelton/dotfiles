vim.cmd([[
  augroup mskelton
    au!

    " Disable continuation comments when using o/O. CR will still add the
    " comment leader.
    au BufEnter * set formatoptions-=c | set formatoptions-=o

    " Auto source
    au BufWritePost */nvim/lua/core/*.lua source <afile>

    " Enable spelling in markdown files
    au FileType markdown setlocal spell spelllang=en_us

    " TS config files use jsonc sntax
    au BufEnter,BufNew tsconfig*.json set ft=jsonc
  augroup END
]])
