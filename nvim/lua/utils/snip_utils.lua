local utils = require("core.utils")

local M = {}

function M.get_filename(_, snip)
	return utils.camel_case(snip.env.TM_FILENAME_BASE)
end

M.export_interface = [[
  export interface {1} {{
    {2}
  }}
]]

return M
