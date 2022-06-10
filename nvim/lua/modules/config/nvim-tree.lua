return function()
  local nvim_tree = safe_require('nvim-tree')
  if not nvim_tree then
    return
  end

  nvim_tree.setup {
    filters = {
      custom = { '.git' },
    },
  }
end
