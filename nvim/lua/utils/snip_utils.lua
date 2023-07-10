local utils = require("core.utils")

local M = {}

function M.get_filename(_, snip)
	return utils.camel_case(snip.env.TM_FILENAME_BASE)
end

function M.get_dir(_, snip)
	return utils.camel_case(string.match(snip.env.TM_DIRECTORY, "[^/]+$"))
end

M.export_interface = [[
  export interface {1} {{
    {2}
  }}
]]

M.get_props_name = function(args, snip)
	return M.get_filename(args, snip) .. "Props"
end

return M
