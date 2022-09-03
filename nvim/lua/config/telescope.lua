return function()
	local actions = require("telescope.actions")
	local layout_strategies = require("telescope.pickers.layout_strategies")
	local dropdown = require("telescope.themes").get_dropdown()

	-- Override the default flex layout with my customized flex layout that uses
	-- the horizontal and modified center layouts.
	layout_strategies.flex = require("config.telescope-layout")

	require("telescope").setup({
		defaults = {
			borderchars = dropdown.borderchars,
			layout_strategy = "flex",
			sorting_strategy = "ascending",
			results_title = false,
			layout_config = {
				preview_cutoff = 1,
				prompt_position = "top",
				center = vim.tbl_extend("error", dropdown.layout_config, {
					anchor = "N",
				}),
				vertical = {
					anchor = "N",
					mirror = true,
				},
				flex = {
					flip_columns = 120,
				},
			},
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
			["ui-select"] = { dropdown },
		},
		pickers = {
			find_files = {
				hidden = true,
				-- Trim leading `./` in fd results
				find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
			},
			live_grep = {
				additional_args = function()
					return { "--hidden" }
				end,
				only_cwd = true,
			},
			oldfiles = { only_cwd = true },
		},
	})

	require("telescope").load_extension("fzf")
	require("telescope").load_extension("ui-select")
end
