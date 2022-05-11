local map = require('utils.map').map

-- Window layout
vim.g.fzf_layout = {
  up = '~90%',
  window = {
    width = 0.8,
    height = 0.8,
    yoffset = 0.5,
    xoffset = 0.5,
  },
}

-- Window colors
vim.g.fzf_colors = {
  fg =       {'fg', 'Normal'},
  bg =       {'bg', 'Normal'},
  hl =       {'fg', 'Type'},
  ['fg+'] =  {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
  ['bg+'] =  {'bg', 'CursorLine', 'CursorColumn'},
  ['hl+'] =  {'fg', 'Function'},
  info =     {'fg', 'Type'},
  marker =   {'fg', 'Type'},
  pointer =  {'fg', 'TSProperty'},
  prompt =   {'fg', 'String'},
}

-- Enable per-command history.
-- CTRL-N and CTRL-P will be automatically bound to next-history and
-- previous-history instead of down and up. If you don't like the change,
-- explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
vim.g.fzf_history_dir = '~/.local/share/fzf-history'

map('n', '<leader>f', ':Files<cr>')
map('n', '<leader>b', ':Buffers<cr>')
map('n', '<leader>h', ':History<cr>')
map('n', '<leader>r', ':Rg<cr>')
map('n', '<leader>B', ':GBranches<cr>')

-- Default command and options
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
vim.env.FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

-- Search in hidden files
vim.cmd(
  [[
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
]]
)
