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
	use({ "folke/tokyonight.nvim", config = conf("tokyonight") })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = conf("nvim-treesitter"),
		requires = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects",
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

	use({
		"nvim-telescope/telescope.nvim",
		config = conf("telescope"),
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
	})

	use({
		"neovim/nvim-lspconfig",
		config = conf("lsp"),
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind-nvim",
		},
	})

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

	use({
		"nvim-lualine/lualine.nvim",
		config = conf("lualine"),
		requires = "kyazdani42/nvim-web-devicons",
	})

	-- TODO: I don't really use this, so probably remove it
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
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

	use({ "goolord/alpha-nvim", config = conf("alpha") })

	-- Git clients
	use({
		"tpope/vim-fugitive",
		requires = "tpope/vim-rhubarb",
	})
	use({
		"TimUntersberger/neogit",
		config = function()
			require("neogit").setup()
		end,
	})

	-- TODO: probably remove, I don't really use this
	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				action_keys = {
					toggle_fold = "t",
				},
			})
		end,
	})

	-- TODO: Build a simpler and more reliable plugin
	use({
		"mskelton/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	})

	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("michaeljsmith/vim-indent-object")
	use("christoomey/vim-tmux-navigator")

	-- Syntaxes
	use("fladson/vim-kitty")
end)
