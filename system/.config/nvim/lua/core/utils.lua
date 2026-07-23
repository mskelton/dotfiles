local M = {}

--- Normalizes the options for a keymap
--- @param opts_or_desc table|string|nil
--- @return table
M.normalize_map_opts = function(opts_or_desc)
  local opts

  if type(opts_or_desc) == "string" then
    opts = { desc = opts_or_desc, silent = true }
  else
    opts = vim.tbl_extend("keep", opts_or_desc or {}, { silent = true })
  end

  return opts
end

--- Sets a keymap
--- @param mode string|table
--- @param key string
--- @param cmd string|function
--- @param opts_or_desc table|string|nil
M.map = function(mode, key, cmd, opts_or_desc)
  vim.keymap.set(mode, key, cmd, M.normalize_map_opts(opts_or_desc))
end

return M
