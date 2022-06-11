if vim.fn.exists 'g:vscode' == 1 then
  -- require 'vscode'
else
  require 'core.utils'
  require 'core.options'
  require 'core.keymap'
  require 'modules'
  require 'core.autocmd'
end
