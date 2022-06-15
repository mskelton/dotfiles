local M = {}

M.setup = function()
  local null_ls = safe_require('null-ls')
  if not null_ls then
    return
  end

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.stylua,
    },
  }
end

return M
