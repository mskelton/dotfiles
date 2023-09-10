---@diagnostic disable: undefined-global

vim.cmd([[

augroup dotfiles
  au!

  " Automatically source core nvim config when saved.
  au BufWritePost */nvim/lua/core/*\(plugins\)\@<!.lua source <afile>

  " Automatically make bin files executable when saved.
  au BufWritePost */bin/* silent !chmod +x <afile>

  " Binary file template
  au BufNewFile */bin/* 0r ~/.skeletons/bin
augroup END

]])
