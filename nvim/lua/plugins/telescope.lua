local nv = { "n", "v" }

return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{
			"<leader>fp",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = nv,
			desc = "Find files",
		},
		{
			"<leader>fP",
			"<cmd>Telescope file_browser path=%:p:h<cr>",
			mode = nv,
			desc = "Open file browser",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").live_grep({ regex = false })
			end,
			mode = nv,
			desc = "Search for exact text",
		},
		{
			"<leader>fS",
			function()
				require("telescope.builtin").live_grep()
			end,
			mode = nv,
			desc = "Search for pattern",
		},
		{
			"<leader>fo",
			function()
				require("telescope.builtin").oldfiles()
			end,
			mode = nv,
			desc = "Open oldfiles",
		},
		{
			"<leader>fw",
			function()
				require("telescope.builtin").buffers({
					ignore_current_buffer = true,
					sort_mru = true,
				})
			end,
			mode = nv,
			desc = "Find buffer",
		},
		{
			"<leader>fn",
			function()
				require("telescope.builtin").git_branches()
			end,
			mode = nv,
			desc = "Find Git branch",
		},
		{
			"<leader>fl",
			function()
				require("telescope.builtin").resume()
			end,
			mode = nv,
			desc = "Open last Telescope picker",
		},
		{
			"<leader>fy",
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			mode = nv,
			desc = "Open LSP symbols",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
			mode = nv,
			desc = "Find help tags",
		},
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			mode = nv,
			desc = "Fuzzy find cin current buffer",
		},
		{
			"z=",
			function()
				require("telescope.builtin").spell_suggest()
			end,
			mode = nv,
			desc = "Suggest spellings for current word",
		},
	},
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
		local Path = require("plenary.path")
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

		local function truncate_path(path)
			local bufnr = vim.api.nvim_get_current_buf()
			local status = require("telescope.state").get_status(bufnr)
			local len = vim.api.nvim_win_get_width(status.results_win)
				- status.picker.selection_caret:len()
				- 2

			return require("plenary.strings").truncate(path, len, nil, 0)
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
				-- Use custom prompt prefix which is more compact than the default.
				prompt_prefix = "❯ ",
				selection_caret = "❯ ",
				-- Truncate long paths in the middle rather than the start/end. This
				-- ensures that you can see the filename which is arguably most
				-- important as well as the top-level directory which is useful for
				-- distinguishing components in a monorepo.
				path_display = function(_, path)
					return truncate_path(path)
				end,
				mappings = {
					i = {
						-- Close rather than going to normal mode
						["<esc>"] = actions.close,

						-- Clear prompt with C-u
						["<C-u>"] = false,

						-- Easier up/down shortcuts
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-h>"] = actions.move_to_top,
						["<C-l>"] = actions.move_to_bottom,

						-- Ctrl/Alt + q is hard to type, so use `i` instead
						["<C-i>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-i>"] = actions.send_selected_to_qflist + actions.open_qflist,
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
					find_command = { "fd", "--type", "f" },
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
				oldfiles = {
					only_cwd = true,
					path_display = function(_, path)
						local cwd = vim.fn.getcwd() .. "/"
						local relative_path = Path:new(path):make_relative(cwd)

						return truncate_path(relative_path)
					end,
				},
			},
		})

		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
	end,
}
