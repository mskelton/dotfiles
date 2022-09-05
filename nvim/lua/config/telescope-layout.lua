local layout_strategies = require("telescope.pickers.layout_strategies")

return function(self, columns, lines, override_layout)
	local layout = layout_strategies.flex(self, columns, lines, override_layout)

	-- Move the results up one line to mirror the aesthetic of the dropdown
	-- theme. This way I can use the same border chars from the dropdown theme
	-- for the vertical and horizontal layouts.
	layout.results.height = layout.results.height + 1
	layout.results.line = layout.results.line - 1

	return layout
end
