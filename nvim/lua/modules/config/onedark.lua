return function()
  local onedark = safe_require('onedark')
  if not onedark then
    return
  end

  onedark.setup {
    code_style = {
      comments = 'italic',
      keywords = 'italic',
      functions = 'bold',
      strings = 'none',
      variables = 'none',
    },
  }

  onedark.load()
end
