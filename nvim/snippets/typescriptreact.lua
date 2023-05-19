---@diagnostic disable: undefined-global
local snip_utils = require("utils.snip_utils")

local function get_props_name(args, snip)
	return snip_utils.get_filename(args, snip) .. "Props"
end

return {
	-- React components
	s("rp", fmt(snip_utils.export_interface, { f(get_props_name), i(1) })),
	s("rpn", f(get_props_name)),
	s(
		"rc",
		fmt(
			[[
        {}{}function {}({}) {{
          return (
            {}
          )
        }}
      ]],
			{
				f(function(args, parent)
					if not string.match(args[2][1], "props:") then
						return ""
					end

					local props = get_props_name(args, parent.snippet)
					local export = ""
					if string.match(args[1][1], "export") then
						export = "export "
					end

					return {
						export .. "interface " .. props .. " {",
						"\t",
						"}",
						"",
						"",
					}
				end, { 1, 2 }),
				c(1, { t("export default "), t("") }),
				f(snip_utils.get_filename),
				c(2, {
					f(function(args, snip)
						return "props: " .. get_props_name(args, snip)
					end),
					t(""),
				}),
				i(0),
			}
		)
	),
	s(
		"rd",
		fmt(
			[[
        {}function {}({}) {{
          return (
            {}
          )
        }}

        export default {}
      ]],
			{
				f(function(args, parent)
					if not string.match(args[1][1], "props:") then
						return ""
					end

					local props = get_props_name(args, parent.snippet)
					return {
						"export interface " .. props .. " {",
						"\t",
						"}",
						"",
						"",
					}
				end, { 1 }),
				f(snip_utils.get_filename),
				c(1, {
					f(function(args, snip)
						return "props: " .. get_props_name(args, snip)
					end),
					t(""),
				}),
				i(0),
				f(snip_utils.get_filename),
			}
		)
	),
}
