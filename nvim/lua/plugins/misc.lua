return {
	{
		"tpope/vim-eunuch",
		cmd = {
			"Cfind",
			"Chmod",
			"Clocate",
			"Copy",
			"Delete",
			"Duplicate",
			"Lfind",
			"Llocate",
			"Mkdir",
			"Move",
			"Remove",
			"Rename",
			"SudoEdit",
			"SudoWrite",
			"Wall",
		},
	},
	{
		"tpope/vim-unimpaired",
		event = "VeryLazy",
		init = function()
			vim.g.nremap = { ["[x"] = "", ["]x"] = "" }
		end,
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
	{
		"michaeljsmith/vim-indent-object",
		event = "VeryLazy",
	},
	{
		"fladson/vim-kitty",
		ft = "kitty",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {
				map = "<M-p>",
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		enabled = false,
		keys = {
			{
				"<C-h>",
				"<cmd>TmuxNavigateLeft<cr>",
				mode = { "n", "v" },
				desc = "Navigate left split or Tmux window",
			},
			{
				"<C-j>",
				"<cmd>TmuxNavigateDown<cr>",
				mode = { "n", "v" },
				desc = "Navigate down one split or Tmux window",
			},
			{
				"<C-k>",
				"<cmd>TmuxNavigateUp<cr>",
				mode = { "n", "v" },
				desc = "Navigate up one split or Tmux window",
			},
			{
				"<C-l>",
				"<cmd>TmuxNavigateRight<cr>",
				mode = { "n", "v" },
				desc = "Navigate right one split or Tmux window",
			},
		},
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
	},
	{
		"knubie/vim-kitty-navigator",
		build = "cp ./*.py ~/.config/kitty/",
		keys = {
			{
				"<C-h>",
				"<cmd>KittyNavigateLeft<cr>",
				mode = { "n", "v" },
				desc = "Navigate left split or Kitty window",
			},
			{
				"<C-j>",
				"<cmd>KittyNavigateDown<cr>",
				mode = { "n", "v" },
				desc = "Navigate down one split or Kitty window",
			},
			{
				"<C-k>",
				"<cmd>KittyNavigateUp<cr>",
				mode = { "n", "v" },
				desc = "Navigate up one split or Kitty window",
			},
			{
				"<C-l>",
				"<cmd>KittyNavigateRight<cr>",
				mode = { "n", "v" },
				desc = "Navigate right one split or Kitty window",
			},
		},
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
	},
	{
		"mskelton/live-reload.nvim",
		lazy = false,
		enabled = function()
			return vim.env.LIVE_RELOAD == "1"
		end,
		opts = {
			root_dir = "~/dev",
			plugins = {
				{ "bandit", dir = "bandit.nvim" },
				{ "live-reload", dir = "live-reload.nvim" },
				{ "local-yokel", dir = "local-yokel.nvim" },
				{ "oldies", dir = "oldies.nvim" },
				{ "termicons", dir = "termicons.nvim" },
				{ "telescope-jumper", dir = "telescope-jumper.nvim" },
			},
		},
	},
	{
		"github/copilot.vim",
		event = "InsertEnter",
		cmd = { "Copilot" },
		init = function()
			vim.g.copilot_filetypes = {
				markdown = false,
				DressingInput = false,
				TelescopePrompt = false,
				TelescopeResults = false,
			}
		end,
	},
	{
		"folke/neodev.nvim",
		ft = "lua",
	},
	{
		"mskelton/local-yokel.nvim",
		cmd = { "E" },
		keys = {
			{
				"]r",
				function()
					require("local-yokel.relatives").next_sibling()
				end,
				mode = { "n", "v" },
				desc = "Go to next sibling file",
			},
			{
				"[r",
				function()
					require("local-yokel.relatives").prev_sibling()
				end,
				mode = { "n", "v" },
				desc = "Go to previous sibling file",
			},
		},
		opts = {
			relatives = {
				postfixes = { "_test" },
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				relative = "editor",
				prefer_width = 50,
				win_options = {
					winblend = 0,
				},
				mappings = {
					i = {
						["<Esc>"] = "Close",
						["<C-u>"] = function()
							vim.api.nvim_buf_set_lines(0, 0, -1, false, {})
						end,
					},
				},
			},
		},
	},
	{
		"mskelton/oldies.nvim",
		keys = {
			{
				"[x",
				function()
					require("oldies").prev()
				end,
				mode = { "n", "v" },
				desc = "Go to newer file",
			},
			{
				"]x",
				function()
					require("oldies").next()
				end,
				mode = { "n", "v" },
				desc = "Go to older file",
			},
		},
		config = true,
	},
	{
		"folke/trouble.nvim",
		cmd = {
			"Trouble",
			"TroubleToggle",
			"TroubleClose",
			"TroubleRefresh",
		},
		config = true,
	},
}
