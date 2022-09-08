vim.cmd([[
  augroup MarkSkelton
    au!
    au BufEnter * set formatoptions-=c | set formatoptions-=o
    au BufWritePost */nvim/lua/core/keymap.lua source <afile>
  augroup END 
]])
