vim.cmd("packadd packer.nvim")

local function conf(name)
	return require(string.format("config.%s", name))
end

require("packer").init({
	compile_path = vim.fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
	package_root = vim.fn.stdpath("data") .. "/site/pack",
})

return require("packer").startup(function(use)
	local function local_use(opts)
		if type(opts) == "string" then
			opts = { opts }
		end

		local root_dir = "~/dev/"
		local dir = vim.split(opts[1], "/", {})[2]

		-- If there is a local copy of the plugin, use it instead of downloading it
		if vim.fn.isdirectory(vim.fn.expand(root_dir .. dir)) == 1 then
			opts[1] = root_dir .. dir
		end

		use(opts)
	end

	use("wbthomason/packer.nvim")
	use("lewis6991/impatient.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = conf("nvim-treesitter"),
		requires = {
			"nvim-treesitter/playground",
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
		},
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
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
		{ "neovim/nvim-lspconfig", config = conf("lsp") },
		"jose-elias-alvarez/null-ls.nvim",
		"jose-elias-alvarez/typescript.nvim",
		"ray-x/lsp_signature.nvim",
		"onsails/lspkind-nvim",
		"folke/neodev.nvim",
	})

	-- Mason
	use({
		{ "williamboman/mason.nvim", config = conf("mason") },
		"williamboman/mason-lspconfig.nvim",
		"jayp0521/mason-null-ls.nvim",
	})

	-- Completion and snippets
	use({
		{ "hrsh7th/nvim-cmp", config = conf("nvim-cmp") },
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
	})
	use({ "L3MON4D3/LuaSnip", config = conf("luasnip") })

	-- Git
	use({
		"tpope/vim-fugitive",
		requires = "tpope/vim-rhubarb",
	})
	local_use({
		"mskelton/bandit.nvim",
		requires = "MunifTanjim/nui.nvim",
		config = conf("bandit"),
	})
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Misc
	use({
		"nvim-lualine/lualine.nvim",
		config = conf("lualine"),
		requires = "kyazdani42/nvim-web-devicons",
	})

	use({
		"akinsho/bufferline.nvim",
		tag = "v2.*",
		requires = "kyazdani42/nvim-web-devicons",
		config = conf("bufferline"),
		event = "BufReadPre",
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
		"christoomey/vim-tmux-navigator",
		config = conf("vim-tmux-navigator"),
	})

	use({
		"ThePrimeagen/harpoon",
		config = conf("harpoon"),
		requires = "nvim-lua/plenary.nvim",
	})

	local_use({
		"mskelton/live-reload.nvim",
		config = conf("live-reload"),
	})

	use({
		"github/copilot.vim",
		config = conf("copilot"),
	})

	use({
		"akinsho/toggleterm.nvim",
		config = conf("toggleterm"),
	})

	use("tpope/vim-abolish")
	use("tpope/vim-eunuch")
	use("tpope/vim-unimpaired")
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("michaeljsmith/vim-indent-object")
	use("fladson/vim-kitty")
	use("kdheepak/lazygit.nvim")
end)
