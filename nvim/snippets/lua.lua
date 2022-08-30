---@diagnostic disable: undefined-global

return {
	parse("fn", "local $1 = function($2)\n\t$0\nend"),
	parse("mod", "local M = {}\n\nM.$0\n\nreturn M"),
	s(
		"req",
		fmt('local {} = require("{}")', {
			f(function(import_name)
				local parts = vim.split(import_name[1][1], ".", true)
				return parts[#parts] or ""
			end, { 1 }),
			i(1),
		})
	),
}
