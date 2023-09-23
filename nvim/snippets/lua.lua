--- @diagnostic disable: undefined-global

return {
	parse("cl", "P($0)"),
	parse("fn", "function $1($2)\n\t$0\nend"),
	parse("lf", "local function $1($2)\n\t$0\nend"),
	parse("mod", "local M = {}\n\nM.$0\n\nreturn M"),
	s(
		"req",
		fmt('local {} = require("{}")', {
			f(function(import_name)
				local parts = vim.split(import_name[1][1], ".", { plain = true })
				return parts[#parts] or ""
			end, { 1 }),
			i(1),
		})
	),
}
