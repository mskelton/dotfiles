return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			config = function()
				require("plenary.filetype").add_file("mskelton")
			end,
		},
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local actions = require("telescope.actions")
		local layout_strategies = require("telescope.pickers.layout_strategies")
		local dropdown = require("telescope.themes").get_dropdown()

		-- Customized flex layout with dropdown style prompt.
		layout_strategies.mskelton = function(self, columns, lines, override_layout)
			local layout =
				layout_strategies.flex(self, columns, lines, override_layout)

			-- Move the results up one line to mirror the aesthetic of the dropdown
			-- theme. This way I can use the same border chars from the dropdown theme
			-- for the vertical and horizontal layouts.
			layout.results.height = layout.results.height + 1
			layout.results.line = layout.results.line - 1

			return layout
		end

		require("telescope").setup({
			defaults = {
				borderchars = dropdown.borderchars,
				layout_strategy = "mskelton",
				sorting_strategy = "ascending",
				results_title = false,
				layout_config = {
					preview_cutoff = 1,
					prompt_position = "top",
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
					additional_args = function(opts)
						local args = { "--hidden" }

						-- Disable regex searching when requested. This is useful since 99% of
						-- the time, I'm doing exact string searching and don't want to use a
						-- regex search.
						if opts.regex == false then
							table.insert(args, "--fixed-strings")
						end

						return args
					end,
					only_cwd = true,
				},
				oldfiles = { only_cwd = true },
			},
		})

		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
	end,
}
