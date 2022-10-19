vim.cmd([[

" Disable continuation comments when using o/O. CR will still add the
" comment leader.
augroup disable_continuation_comments
  au!
  au BufEnter * set formatoptions-=c | set formatoptions-=o
augroup END

augroup auto_source_dotfiles
  au!
  au BufWritePost */nvim/lua/core/*.lua source <afile>
augroup END

augroup markdown_spell_check
  au!
  au FileType markdown setlocal spell spelllang=en_us
augroup END

augroup log_no_wrap
  au!
  au BufEnter,BufNew *.log setlocal nowrap
augroup END

augroup zet_template
  au!
  au BufNewFile */zettels/*.md 0r ~/.config/nvim/templates/zet.md
augroup END

augroup incsearch_hl
 au!
 au CmdlineEnter /,\? :set hlsearch
 au CmdlineLeave /,\? :set nohlsearch
augroup END

]])
