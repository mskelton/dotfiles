vim.cmd("packadd packer.nvim")

local function conf(name)
	return require(string.format("config.%s", name))
end

require("packer").init({
	compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
	package_root = vim.fn.stdpath("data") .. "/site/pack",
})

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = conf("nvim-treesitter"),
		requires = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
		},
	})

	use({
		"RRethy/nvim-treesitter-endwise",
		config = function()
			require("nvim-treesitter.configs").setup({
				endwise = { enable = true },
			})
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = conf("telescope"),
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = conf("lsp"),
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind-nvim",
			"folke/lua-dev.nvim",
		},
	})

	-- Completion and snippets
	use({
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
	})

	use({
		"L3MON4D3/LuaSnip",
		config = conf("luasnip"),
	})

	-- Git
	use({ "tpope/vim-fugitive", requires = "tpope/vim-rhubarb" })
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup()
		end,
	})

	-- Misc
	use({
		"nvim-lualine/lualine.nvim",
		config = conf("lualine"),
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		"folke/tokyonight.nvim",
		config = conf("tokyonight"),
	})

	use({
		"goolord/alpha-nvim",
		config = conf("alpha"),
		disable = true,
	})

	use({
		"akinsho/toggleterm.nvim",
		config = conf("toggleterm"),
	})

	use({
		"christoomey/vim-tmux-navigator",
		config = conf("vim-tmux-navigator"),
	})

	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("michaeljsmith/vim-indent-object")
	use("fladson/vim-kitty")
end)
