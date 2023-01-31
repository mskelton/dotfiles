return {
	{
		"tpope/vim-abolish",
		event = "CmdLineEnter",
	},
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
		config = true,
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
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ho",
				function()
					require("harpoon.ui").toggle_quick_menu()
				end,
				mode = { "n", "v" },
				desc = "Open Harpoon menu",
			},
			{
				"<leader>ha",
				function()
					require("harpoon.mark").add_file()
				end,
				mode = { "n", "v" },
				desc = "Add file to Harpoon",
			},
			{
				"]h",
				function()
					require("harpoon.ui").nav_next()
				end,
				mode = "n",
				desc = "Next harpoon mark",
			},
			{
				"[h",
				function()
					require("harpoon.ui").nav_prev()
				end,
				mode = "n",
				desc = "Previous harpoon mark",
			},
		},
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
			},
		},
	},
	{
		"github/copilot.vim",
		event = "InsertEnter",
		cmd = { "Copilot" },
		config = function()
			vim.g.copilot_filetypes = {
				TelescopePrompt = false,
			}
		end,
	},
	{
		"folke/neodev.nvim",
		ft = "lua",
	},
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"GBrowse",
			"GDelete",
			"GMove",
			"GRename",
			"Gdiffsplit",
			"Gedit",
			"Ggrep",
			"Git",
			"Gread",
			"Gsplit",
			"Gvdiffsplit",
			"Gwrite",
		},
		dependencies = { "tpope/vim-rhubarb" },
	},
	{
		"mskelton/bandit.nvim",
		keys = {
			{
				"<leader>vc",
				function()
					require("bandit").commit()
				end,
				mode = { "n", "v" },
				desc = "Commit changes",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = true,
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
