local utils = require("core.utils")
local snip_utils = require("utils.snip_utils")

local function get_hook_name(args, snip)
	-- If the filename has `use` in the name, it will become `UseX` which is not
	-- what we want. Also, if a file doesn't have `use` in the name, we need to
	-- add it automatically.
	return "use" .. string.gsub(snip_utils.get_filename(args, snip), "^Use", "")
end

local function get_options_name(args, snip)
	return utils.camel_case(get_hook_name(args, snip)) .. "Options"
end

return {
	-- React hooks
	s("ro", fmt(snip_utils.export_interface, { f(get_options_name), i(1) })),
	s("ron", f(get_options_name)),
	s(
		"rh",
		fmt(
			[[
        {}function {}({}) {{
          return (
            {}
          )
        }}
        {}
      ]],
			{
				c(1, { t("export "), t("") }),
				f(get_hook_name),
				c(2, {
					f(function(args, snip)
						return "options: " .. get_options_name(args, snip)
					end),
					t(""),
				}),
				i(0),
				d(3, function(args, parent)
					if args[2][1] == "" then
						return sn(nil, t(""))
					end

					local options = get_options_name(args, parent.snippet)
					return sn(nil, {
						t({
							"",
							args[1][1] .. "interface " .. options .. " {",
							"\t",
							"}",
							"",
						}),
					})
				end, { 1, 2 }),
			}
		)
	),
	-- Playwright
	s(
		"pw-collection",
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
