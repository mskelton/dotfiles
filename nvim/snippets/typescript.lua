--- @diagnostic disable: undefined-global
local snip_utils = require("utils.snip_utils")

local function get_hook_name(args, snip)
	-- If the filename has `use` in the name, it will become `UseX` which is not
	-- what we want. Also, if a file doesn't have `use` in the name, we need to
	-- add it automatically.
	return "use" .. string.gsub(snip_utils.get_filename(args, snip), "^Use", "")
end

return {
	parse("rec", "Record<string, unknown>$0"),
	s("rp", fmt(snip_utils.export_type, { f(snip_utils.get_props_name), i(1) })),
	s("rpn", f(snip_utils.get_props_name)),
	-- TypeScript
	s(
		"tt",
		fmt("{}type {} = {}", {
			c(1, { t("export "), t("") }),
			i(2),
			i(0),
		})
	),
	s(
		"tin",
		fmt("{}type {} = {{\n\t{}\n}}", {
			c(1, { t(""), t("export ") }),
			i(2),
			i(0),
		})
	),
	-- React
	s(
		"ed",
		fmt('export {{ {} }} from "./{}"', {
			f(snip_utils.get_dir),
			f(snip_utils.get_dir),
		})
	),
	s(
		"rh",
		fmt(
			[[
        {}{}function {}({}) {{
          {}
        }}
      ]],
			{
				f(function(args, parent)
					if not string.match(args[2][1], "{") then
						return ""
					end

					local props = snip_utils.get_props_name(args, parent.snippet)
					local export = ""
					if string.match(args[1][1], "export") then
						export = "export "
					end

					return {
						export .. "type " .. props .. " = {",
						"\t",
						"}",
						"",
						"",
					}
				end, { 1, 2 }),
				c(1, { t("export "), t("") }),
				f(get_hook_name),
				c(2, {
					f(function(args, snip)
						return "{ }: " .. snip_utils.get_props_name(args, snip)
					end),
					t(""),
				}),
				i(0),
			}
		)
	),
	-- Playwright
	s(
		"pcol",
		fmt(
			[[
        {}{}class {} extends Collection {{
          {}{}
        }}
      ]],
			{
				c(1, {
					t({ "import Collection from 'lariat'", "", "" }),
					t(""),
				}),
				c(2, { t("export "), t("") }),
				i(3, "MyCollection"),
				c(4, {
					sn(nil, {
						i(1),
						t({ "constructor (page: Page) {", "\t\t" }),
						i(2),
						t({ "\t}", "", "\t" }),
					}),
					t(""),
				}),
				i(0),
			}
		)
	),
}
