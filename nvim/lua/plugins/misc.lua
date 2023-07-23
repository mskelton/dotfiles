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
		"kdheepak/lazygit.nvim",
		keys = {
			{
				"<leader>lg",
				"<cmd>LazyGit<cr>",
				mode = { "n", "v" },
				desc = "Open LazyGit",
			},
		},
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
			},
		},
	},
	{
		"github/copilot.vim",
		event = "InsertEnter",
		cmd = { "Copilot" },
		init = function()
			vim.g.copilot_filetypes = {
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
		config = {
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
		"nvim-tree/nvim-web-devicons",
		dependencies = { "folke/trouble.nvim" },
		config = true,
	},
}
