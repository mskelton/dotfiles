---@diagnostic disable: undefined-global

vim.cmd([[

" Automatically source core nvim config when saved.
augroup auto_source
  au!
  au BufWritePost */nvim/lua/core/*\(plugins\)\@<!.lua source <afile>
augroup END

" Automatically make bin files executable when saved.
augroup auto_chmod
  au!
  au BufWritePost */bin/* silent !chmod +x <afile>
augroup END

]])
