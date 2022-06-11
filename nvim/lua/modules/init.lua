local function conf(name)
  return require(string.format('modules.config.%s', name))
end

local plugins = {
  {
    'mskelton/onedark.nvim',
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
        run = 'make',
      },
    },
  },
  {
    'kyazdani42/nvim-tree.lua',
    config = conf 'nvim-tree',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
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
      'onsails/lspkind-nvim',
      'quangnguyen30192/cmp-nvim-ultisnips',
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    config = conf 'lualine',
    requires = { 'kyazdani42/nvim-web-devicons' },
  },
  { 'airblade/vim-gitgutter' },
  { 'jiangmiao/auto-pairs' },
  { 'SirVer/ultisnips' },
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
