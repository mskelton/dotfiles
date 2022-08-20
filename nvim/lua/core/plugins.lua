local function conf(name)
	return require(string.format("config.%s", name))
end

local plugins = {
	{
		"folke/tokyonight.nvim",
		config = conf("tokyonight"),
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = conf("nvim-treesitter"),
		requires = {
			"nvim-treesitter/playground",
			"windwp/nvim-ts-autotag",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		config = conf("telescope"),
		requires = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				config = function()
					require("telescope").load_extension("fzf")
				end,
				run = "make",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = conf("lsp"),
		requires = {
			"williamboman/nvim-lsp-installer",
			"jose-elias-alvarez/null-ls.nvim",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind-nvim",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = conf("nvim-cmp"),
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind-nvim",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		config = conf("lualine"),
		requires = "kyazdani42/nvim-web-devicons",
	},
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		config = conf("luasnip"),
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		config = conf("alpha"),
	},
	{
		"tpope/vim-fugitive",
		requires = "tpope/vim-rhubarb",
	},
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = conf("todo-comments"),
	},
	{
		"RRethy/nvim-treesitter-endwise",
		config = function()
			require("nvim-treesitter.configs").setup({
				endwise = { enable = true },
			})
		end,
	},
	{ "tpope/vim-eunuch" },
	{ "tpope/vim-unimpaired" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "folke/trouble.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	{ "fladson/vim-kitty" },
}

local install_path = vim.fn.stdpath("data")
	.. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd("packadd packer.nvim")
end

local packer = require("packer")
packer.init({
	compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
	package_root = vim.fn.stdpath("data") .. "/site/pack",
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	for _, plugin in ipairs(plugins) do
		use(plugin)
	end
end)
