return function()
  local telescope = safe_require('telescope')
  if not telescope then
    return
  end

  local actions = require('telescope.actions')

  telescope.setup {
    defaults = {
      prompt_prefix = '❯ ',
      selection_caret = '❯ ',
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-u>"] = false, -- Clear prompt with C-u
        },
      },
    }
  }
end
