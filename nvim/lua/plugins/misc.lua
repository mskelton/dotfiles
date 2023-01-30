return {
	"tpope/vim-abolish",
	"tpope/vim-eunuch",
	"tpope/vim-unimpaired",
	"tpope/vim-surround",
	{ "tpope/vim-repeat", event = "VeryLazy" },
	"michaeljsmith/vim-indent-object",
	"fladson/vim-kitty",
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>v;", "<cmd>LazyGit<cr>", mode = { "n", "v" } },
		},
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"christoomey/vim-tmux-navigator",
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		config = function()
			local map = require("core.utils").map

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
		cmd = { "Git", "G", "Gvdiffsplit" },
		dependencies = { "tpope/vim-rhubarb" },
	},
	{
		"mskelton/bandit.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = true,
		keys = {
			{
				"<leader>vc",
				function()
					require("bandit").commit()
				end,
				mode = { "n", "v" },
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
