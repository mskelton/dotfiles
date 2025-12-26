vim.cmd([[

augroup mskelton
  au!

  " Disable continuation comments when using o/O. CR will still add the
  " comment leader.
  au BufEnter * set formatoptions-=c | set formatoptions-=o

  " Enable search highlighting while searching
  au CmdlineEnter /,\? :set hlsearch
  au CmdlineLeave /,\? :set nohlsearch
augroup END

]])
