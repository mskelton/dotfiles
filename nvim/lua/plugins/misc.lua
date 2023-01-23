return {
	"tpope/vim-abolish",
	"tpope/vim-eunuch",
	"tpope/vim-unimpaired",
	"tpope/vim-surround",
	{ "tpope/vim-repeat", event = "VeryLazy" },
	"michaeljsmith/vim-indent-object",
	"fladson/vim-kitty",
	"kdheepak/lazygit.nvim",
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"christoomey/vim-tmux-navigator",
		config = function()
			local map = require("core.utils").map

			vim.g.tmux_navigator_no_mappings = 1

			map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
			map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
			map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
			map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
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
		enabled = false,
		opts = {
			root_dir = "~/dev",
			plugins = {
				{ "bandit", dir = "bandit.nvim" },
				{ "live-reload", dir = "live-reload.nvim" },
			},
		},
	},
	{
		"github/copilot.vim",
		event = "InsertEnter",
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
		cmd = { "Git", "G", "Gvdiffsplit" },
		dependencies = { "tpope/vim-rhubarb" },
	},
	{
		"mskelton/bandit.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = true,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = true,
	},
}
