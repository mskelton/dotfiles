---@diagnostic disable: undefined-global

return {
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
