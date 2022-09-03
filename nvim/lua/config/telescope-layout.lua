local layout_strategies = require("telescope.pickers.layout_strategies")

local options = {
	anchor = "Which edge/corner to pin the picker to",
	flip_columns = "The number of columns required to move to horizontal mode",
	flip_lines = "The number of lines required to move to horizontal mode",
	height = "How tall to make Telescope's entire layout",
	horizontal = "Options to pass when switching to horizontal layout",
	mirror = "Flip the location of the results/prompt and preview windows",
	prompt_position = "Where to place prompt window.",
	scroll_speed = "The number of lines to scroll through the previewer",
	vertical = "Options to pass when switching to vertical layout",
	width = "How wide to make Telescope's entire layout",
}

local function get_layout_config(self, override_layout)
	return layout_strategies._validate_layout_config(
		"flex",
		options,
		vim.tbl_deep_extend(
			"keep",
			vim.F.if_nil(override_layout, {}),
			vim.F.if_nil(self.layout_config, {})
		)
	)
end

return function(self, columns, lines, override_layout)
	local layout_config = get_layout_config(self, override_layout)
	local flip_columns = vim.F.if_nil(layout_config.flip_columns, 100)
	local flip_lines = vim.F.if_nil(layout_config.flip_lines, 20)

	if columns < flip_columns and lines > flip_lines then
		self.__flex_strategy = "center"
		return layout_strategies.center(self, columns, lines, layout_config.center)
	else
		self.__flex_strategy = "horizontal"
		local layout = layout_strategies.horizontal(
			self,
			columns,
			lines,
			layout_config.horizontal
		)

		-- Move the results up one line to mirror the aesthetic of the dropdown
		-- theme. This way I can use the same border chars from the dropdown theme
		-- for the centered and horizontal layouts.
		layout.results.height = layout.results.height + 1
		layout.results.line = layout.results.line - 1

		return layout
	end
end
