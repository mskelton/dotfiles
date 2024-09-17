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
			function()
				require("telescope").extensions.file_browser.file_browser({
					path = vim.fn.expand("%:p:h"),
				})
			end,
			mode = nv,
			desc = "Open file browser",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").live_grep({
					prompt_title = "Find Exact String",
					regex = false,
				})
			end,
			mode = nv,
			desc = "Search for exact text",
		},
		{
			"<leader>fS",
			function()
				require("telescope.builtin").live_grep({
					prompt_title = "Find Pattern",
				})
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
			"<leader>fb",
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
				require("telescope.builtin").git_branches({
					show_remote_tracking_branches = false,
				})
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
				require("telescope.builtin").lsp_document_symbols({
					prompt_title = "Symbols",
				})
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
			"<leader>fa",
			function()
				require("telescope.builtin").find_files({
					prompt_title = "Find Adjacent Files",
					cwd = vim.fn.expand("%:h"),
				})
			end,
			mode = nv,
			desc = "Find adjacent files",
		},
		{
			"<leader>fw",
			function()
				require("telescope.builtin").live_grep({
					prompt_title = "Find Exact String",
					regex = false,
				})
			end,
			mode = "n",
			desc = "Find word under cursor",
		},
		{
			"<leader>jo",
			function()
				require("telescope").extensions.jumper.list()
			end,
			mode = nv,
			desc = "Find directories",
		},
		{
			"<leader>fm",
			function()
				require("telescope").extensions.node_modules.list()
			end,
			mode = nv,
			desc = "Find node_modules",
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
		{
			"<leader>jr",
			function()
				require("jumper").jump_to_root()
			end,
			mode = nv,
			desc = "Jump to project root",
		},
		{
			"<leader>jc",
			function()
				require("jumper").jump_to_current_directory()
			end,
			mode = nv,
			desc = "Jump to active buffer directory",
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
		"nvim-telescope/telescope-node-modules.nvim",
		"mskelton/jumper.nvim",
	},
	config = function()
		local Path = require("plenary.path")
		local actions = require("telescope.actions")
		local actions_state = require("telescope.actions.state")
		local layout = require("telescope.actions.layout")
		local layout_strategies = require("telescope.pickers.layout_strategies")
		local dropdown = require("telescope.themes").get_dropdown()
		local state = { opts = {} }

		--- Customized flex layout with dropdown style prompt.
		layout_strategies.mskelton = function(self, columns, lines, override_layout)
			local flex = layout_strategies.flex(self, columns, lines, override_layout)

			--- Move the results up one line to mirror the aesthetic of the dropdown
			--- theme. This way I can use the same border chars from the dropdown theme
			--- for the vertical and horizontal layouts.
			flex.results.height = flex.results.height + 1
			flex.results.line = flex.results.line - 1

			return flex
		end

		local function truncate_path(opts, path)
			local padding = opts.__prefix or 3
			local bufnr = vim.api.nvim_get_current_buf()
			local status = require("telescope.state").get_status(bufnr)
			local len = vim.api.nvim_win_get_width(status.results_win)
				- status.picker.selection_caret:len()
				- padding

			return require("plenary.strings").truncate(path, len, nil, 0)
		end

		--- Add the `--no-ignore` flag to the finder arguments when requested. This
		--- manages the hack to get around the fact that the `opts` object is not
		--- persisted by Telescope.
		---
		--- @param picker_type string
		--- @param fn fun(opts: table): table
		--- @return fun(opts: table): table
		local function with_ignore(picker_type, fn)
			return function(opts)
				local args = fn(opts)

				--- Updated the saved state so we can restore state later
				state.opts = opts or {}
				state.picker_type = picker_type

				--- Add the `--no-ignore` flag when requested
				if state.opts.no_ignore then
					vim.list_extend(args, {
						"--no-ignore",
						"--ignore-file=.gitignore",
					})
				end

				return args
			end
		end

		require("telescope").setup({
			defaults = {
				borderchars = dropdown.borderchars,
				layout_strategy = "mskelton",
				sorting_strategy = "ascending",
				scroll_strategy = "limit",
				results_title = false,
				preview = {
					treesitter = false,
				},
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
				--- Use custom prompt prefix which is more compact than the default.
				prompt_prefix = "❯ ",
				selection_caret = "❯ ",
				--- Truncate long paths in the middle rather than the start/end. This
				--- ensures that you can see the filename which is arguably most
				--- important as well as the top-level directory which is useful for
				--- distinguishing components in a monorepo.
				path_display = function(opts, path)
					return truncate_path(opts, path)
				end,
				mappings = {
					i = {
						--- Close rather than going to normal mode
						["<esc>"] = actions.close,

						--- Clear prompt with C-u
						["<C-u>"] = false,

						--- Easier up/down shortcuts
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-h>"] = actions.move_to_top,
						["<C-l>"] = actions.move_to_bottom,

						["<C-o>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-o>"] = actions.send_selected_to_qflist + actions.open_qflist,

						--- Toggle preview
						["<C-y>"] = layout.toggle_preview,

						--- Paste ignoring leading/trailing whitespace and only keep the first line
						["<C-p>"] = function(bufnr)
							local picker = actions_state.get_current_picker(bufnr)
							local first_line =
								vim.fn.getreg("+"):gsub("^%s*(.-)%s*$", "%1"):match("^[^\n]*")

							picker:set_prompt(first_line)
						end,

						--- Use `i` to toggle the `--no-ignore` flag
						["<C-i>"] = function(bufnr)
							local picker = actions_state.get_current_picker(bufnr)

							if
								state.picker_type ~= "find_files"
								and state.picker_type ~= "live_grep"
							then
								return vim.notify(
									string.format(
										"Cannot toggle `--no-ignore` flag for picker: %s",
										state.picker_type
									),
									vim.log.levels.WARN
								)
							end

							require("telescope.builtin")[state.picker_type]({
								prompt_title = picker.prompt_title,
								default_text = picker:_get_prompt(),
								cwd = picker.cwd,
								no_ignore = not state.opts.no_ignore,
								regex = state.opts.regex,
							})
						end,
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
					--- Trim leading whitespace in grep results
					"--trim",
				},
			},
			extensions = {
				jumper = {
					patterns = {
						"apps/*",
						"packages/*",
					},
				},
				["ui-select"] = { dropdown },
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = with_ignore("find_files", function()
						return { "fd", "--type", "f" }
					end),
				},
				live_grep = {
					additional_args = with_ignore("live_grep", function(opts)
						local args = { "--hidden" }

						--- Disable regex searching when requested. This is useful since 99% of
						--- the time, I'm doing exact string searching and don't want to use a
						--- regex search.
						if opts.regex == false then
							table.insert(args, "--fixed-strings")
						end

						return args
					end),
					only_cwd = true,
				},
				oldfiles = {
					only_cwd = true,
					path_display = function(opts, path)
						local cwd = vim.fn.getcwd() .. "/"
						local relative_path = Path:new(path):make_relative(cwd)

						return truncate_path(opts, relative_path)
					end,
				},
			},
		})

		require("telescope").load_extension("file_browser")
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("node_modules")
		require("telescope").load_extension("jumper")
	end,
}
