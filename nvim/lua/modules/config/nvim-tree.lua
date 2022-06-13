return function()
  local nvim_tree = safe_require('nvim-tree')
  if not nvim_tree then
    return
  end

  nvim_tree.setup {
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    update_focused_file = {
      enable = true,
    },
    filters = {
      custom = { '.git' },
    },
  }
end
