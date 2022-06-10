return function()
  local lualine = safe_require('lualine')
  if not lualine then
    return
  end

  lualine.setup {
    tabline = {
      lualine_a = {'buffers'},
    }
  }
end
