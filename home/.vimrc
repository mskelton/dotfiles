noremap ; :
noremap ; :
noremap <leader>; ;
noremap <leader>q q:
noremap <leader>q q:

noremap ,s <cmd>w ++p<cr>
noremap ,S <cmd>noa w<cr>
noremap ,q <cmd>qa<cr>
noremap ,c <cmd>clo<cr>
noremap ,w <cmd>call CloseOrDelete()<cr>

function CloseOrDelete()
  if winnr('$') > 1
    close
  else
    bdelete!
  endif
endfunction

