local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local function conf(name)
	return require(string.format("config.%s", name))
end

return require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = conf("tokyonight"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		-- build = ":TSUpdate",
		-- event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
		},
		config = conf("treesitter"),
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = conf("telescope"),
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind-nvim",
		},
		config = conf("lsp"),
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jayp0521/mason-null-ls.nvim",
		},
		config = conf("mason"),
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
		},
		config = conf("nvim-cmp"),
	},
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		config = conf("luasnip"),
	},
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "G", "Gvdiffsplit" },
		dependencies = { "tpope/vim-rhubarb" },
	},
	{
		"mskelton/bandit.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		config = conf("bandit"),
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
		-- config = function()
		-- 	require("gitsigns").setup()
		-- end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = conf("lualine"),
	},
	{
		"akinsho/bufferline.nvim",
		event = "BufReadPre",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = conf("bufferline"),
	},

	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = conf("comment"),
	},
	{
		"windwp/nvim-autopairs",
		config = true,
	},
	{
		"christoomey/vim-tmux-navigator",
		config = conf("vim-tmux-navigator"),
	},
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = conf("harpoon"),
	},
	{
		"mskelton/live-reload.nvim",
		config = true,
	},
	{
		"github/copilot.vim",
		config = conf("copilot"),
	},
	{
		"akinsho/toggleterm.nvim",
		config = conf("toggleterm"),
	},
	{
		"folke/neodev.nvim",
		ft = "lua",
	},
	"tpope/vim-abolish",
	"tpope/vim-eunuch",
	"tpope/vim-unimpaired",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"michaeljsmith/vim-indent-object",
	"fladson/vim-kitty",
	"kdheepak/lazygit.nvim",
})
