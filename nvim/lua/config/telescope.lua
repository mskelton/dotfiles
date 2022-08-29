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
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- Trim leading whitespace in grep results
				"--trim",
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
		pickers = {
			buffers = { theme = "dropdown" },
			current_buffer_fuzzy_find = { theme = "dropdown" },
			find_files = {
				theme = "dropdown",
				hidden = true,
				-- Trim leading `./` in fd results
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
			live_grep = {
				additional_args = function()
					return { "--hidden" }
				end,
				only_cwd = true,
				theme = "dropdown",
			},
			oldfiles = {
				only_cwd = true,
				theme = "dropdown",
			},
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("ui-select")
end
