require'lualine'.setup {
  options = {
    theme = 'onedark',
  },
  sections = {
    lualine_x = {'encoding', 'fileformat', 'filetype'},
  },
  tabline = {
    lualine_a = {'buffers'},
  }
}
