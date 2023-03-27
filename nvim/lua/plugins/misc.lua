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
		enabled = false,
		opts = {
			root_dir = "~/dev",
			plugins = {
				{ "bandit", dir = "bandit.nvim" },
				{ "live-reload", dir = "live-reload.nvim" },
				{ "local-yokel", dir = "local-yokel.nvim" },
				{ "termicons", dir = "termicons.nvim" },
			},
		},
	},
	{
		"github/copilot.vim",
		event = "VimEnter",
		cmd = { "Copilot" },
		config = function()
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
		config = true,
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
			},
		},
	},
}
