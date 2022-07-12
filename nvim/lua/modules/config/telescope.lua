return function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			layout_strategy = "vertical",
			prompt_prefix = "❯ ",
			selection_caret = "❯ ",
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-u>"] = false, -- Clear prompt with C-u
				},
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			live_grep = {
				additional_args = function(opts)
					return { "--hidden" }
				end,
				only_cwd = true,
			},
			oldfiles = {
				only_cwd = true,
			},
		},
	})
end
