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
        {}
      ]],
			{
				c(1, {
					t({ "import React from 'react'", "", "" }),
					t(""),
				}),
				c(2, { t("export "), t("") }),
				f(snip_utils.get_filename),
				c(3, {
					f(function(args, snip)
						return "props: " .. get_props_name(args, snip)
					end),
					t(""),
				}),
				i(0),
				d(4, function(args, parent)
					if args[2][1] == "" then
						return sn(nil, t(""))
					end

					local props = get_props_name(args, parent.snippet)
					return sn(nil, {
						t({
							"",
							args[1][1] .. "interface " .. props .. " {",
							"\t",
							"}",
							"",
						}),
					})
				end, { 2, 3 }),
			}
		)
	),
}
