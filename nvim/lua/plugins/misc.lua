local utils = require("core.utils")

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
			"Delete",
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
				"<leader>v;",
				"<cmd>LazyGit<cr>",
				mode = utils.nv,
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
				mode = utils.nv,
				desc = "Navigate left split or Tmux window",
			},
			{
				"<C-j>",
				"<cmd>TmuxNavigateDown<cr>",
				mode = utils.nv,
				desc = "Navigate down one split or Tmux window",
			},
			{
				"<C-k>",
				"<cmd>TmuxNavigateUp<cr>",
				mode = utils.nv,
				desc = "Navigate up one split or Tmux window",
			},
			{
				"<C-l>",
				"<cmd>TmuxNavigateRight<cr>",
				mode = utils.nv,
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
		config = function()
			local map = require("core.utils").map
			local ui = require("harpoon.ui")

			map("n", "<leader>ho", function()
				ui.toggle_quick_menu()
			end)

			map("n", "<leader>ha", function()
				require("harpoon.mark").add_file()
			end)

			map("n", "[h", function()
				ui.nav_next()
			end)

			map("n", "]h", function()
				ui.nav_prev()
			end)
		end,
	},
	{
		"mskelton/live-reload.nvim",
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
		"akinsho/toggleterm.nvim",
		opts = {
			autochdir = true,
			direction = "float",
			insert_mappings = true,
			open_mapping = "<C-\\>",
			shade_terminals = false,
			float_opts = {
				border = "rounded",
			},
		},
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
		dependencies = { "MunifTanjim/nui.nvim" },
		keys = {
			{
				"<leader>vc",
				function()
					require("bandit").commit()
				end,
				mode = utils.nv,
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
}
