function camel_case(str)
	return string.gsub("-" .. str, "(%-)(%l)", function(_, b)
		return string.upper(b)
	end)
end

function get_component_name(_, snip)
	return camel_case(snip.env.TM_FILENAME_BASE)
end

function get_props_name(args, snip)
	return get_component_name(args, snip) .. "Props"
end

return {
	s(
		"rp",
		fmt(
			[[
        export interface {1} {{
          {2}
        }}
      ]],
			{ f(get_props_name), i(1) }
		)
	),
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
				f(get_component_name),
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

					local props = camel_case(parent.snippet.env.TM_FILENAME_BASE)
					return sn(nil, {
						t({ "", args[1][1] .. "interface " .. props .. "Props {", "\t", "}", "" }),
					})
				end, { 2, 3 }),
			}
		)
	),
}
