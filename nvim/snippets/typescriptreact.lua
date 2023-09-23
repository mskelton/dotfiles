--- @diagnostic disable: undefined-global
local snip_utils = require("utils.snip_utils")

return {
	parse("chil", "{ children }: { children: React.ReactNode }"),
	-- React components
	s(
		"rd",
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

					local props = snip_utils.get_props_name(args, parent.snippet)
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
						return "props: " .. snip_utils.get_props_name(args, snip)
					end),
					t(""),
				}),
				i(0),
			}
		)
	),
}
