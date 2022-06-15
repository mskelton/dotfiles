local function conf(name)
  return require(string.format('modules.config.%s', name))
end

local plugins = {
  {
    'navarasu/onedark.nvim',
    config = conf 'onedark',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = conf 'nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    config = conf 'telescope',
    requires = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        config = function()
          require("telescope").load_extension('fzf')
        end,
        run = 'make',
      },
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
        requires = {
          "tami5/sqlite.lua",
          "kyazdani42/nvim-web-devicons",
        },
      },
    },
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = conf 'nvim-tree',
    requires = { 'kyazdani42/nvim-web-devicons' },
  },
  {
    'neovim/nvim-lspconfig',
    config = conf 'lsp',
    requires = {
      'williamboman/nvim-lsp-installer',
      'jose-elias-alvarez/null-ls.nvim',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    config = conf 'nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'onsails/lspkind-nvim',
      'saadparwaiz1/cmp_luasnip',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = conf 'lualine',
    requires = { 'kyazdani42/nvim-web-devicons' },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = conf 'gitsigns',
  },
  {
    'L3MON4D3/LuaSnip',
    config = conf 'luasnip',
  },
  { 'jiangmiao/auto-pairs' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-eunuch' },
  { 'tpope/vim-fugitive' },
}

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd 'packadd packer.nvim'
end

local packer = safe_require('packer')
if packer then
  packer.init {
    compile_path = vim.fn.stdpath 'data' .. '/site/plugin/packer_compiled.lua',
    package_root = vim.fn.stdpath 'data' .. '/site/pack',
  }

  return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end)
end