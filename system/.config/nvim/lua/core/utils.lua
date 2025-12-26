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

--- @class Map
--- @field set fun(): Map
--- @field del fun(): Map

--- Creates a keymap function
--- @param mode string|table
--- @param key string
--- @param cmd string|function
--- @param opts_or_desc table|string|nil
--- @return Map
M.map_fn = function(mode, key, cmd, opts_or_desc)
  local Map = {}
  Map.__index = Map

  function Map:new()
    local instance = setmetatable({}, self)
    return instance
  end

  function Map:set()
    vim.keymap.set(mode, key, cmd, M.normalize_map_opts(opts_or_desc))
    return self
  end

  function Map:del()
    vim.keymap.del(mode, key)
    return self
  end

  return Map:new():set()
end

--- Get's the truncation width for the current window size.
--- @param default number
--- @param spec table
M.get_trunc_width = function(default, spec)
  local current_width = vim.fn.winwidth(0)

  for _, item in pairs(spec) do
    if current_width < item.max then
      return item.width
    end
  end

  return default
end

--- Returns a function that truncates a string to the provided width based on
--- the current window size.
--- @param default number
--- @param spec table
M.trunc = function(default, spec)
  --- @param str string
  return function(str)
    local width = M.get_trunc_width(default, spec)

    return require("plenary.strings").truncate(str, width, nil, 0)
  end
end

--- Returns a function that returns true when the current window width is
--- greater than the provided width.
--- @param width number
M.min_width = function(width)
  return function()
    return vim.fn.winwidth(0) > width
  end
end

return M
