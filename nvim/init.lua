---------------------------------------------------------------------------
-- General settings
---------------------------------------------------------------------------

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.clipboard = 'unnamed'
vim.opt.confirm = true
vim.opt.shortmess = vim.opt.shortmess + 'I'
vim.opt.updatetime = 100
vim.opt.colorcolumn = '80'

-- set spell
-- set wildmode=longest:full,full

---------------------------------------------------------------------------
-- Key maps
---------------------------------------------------------------------------
local map = require('utils.map').map

vim.g.mapleader = ' '

map('n', '<leader>k', ':nohlsearch<cr>')
map('n', '<leader>w', ':bdelete<cr>')

---------------------------------------------------------------------------
-- Plugins
---------------------------------------------------------------------------

vim.api.nvim_exec(
[[
if empty(glob('~/.local/share/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]],
true)

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugins')

-- Fuzzy finder
Plug('junegunn/fzf', { ['do'] = ':call fzf#install()' })
Plug('junegunn/fzf.vim')
Plug('stsewd/fzf-checkout.vim')

-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-treesitter/playground')

-- LSP
Plug('neovim/nvim-lspconfig')
Plug('jose-elias-alvarez/nvim-lsp-ts-utils')
Plug('nvim-lua/plenary.nvim')
-- Plug('neoclide/coc.nvim', { branch = 'release' })

-- Completion
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('quangnguyen30192/cmp-nvim-ultisnips')

-- Theme
Plug('mskelton/onedark.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('ryanoasis/vim-devicons')
Plug('kyazdani42/nvim-web-devicons')

-- Git
Plug('tpope/vim-fugitive')
Plug('airblade/vim-gitgutter')

-- Misc
Plug('SirVer/ultisnips')
Plug('tpope/vim-commentary')
Plug('tpope/vim-eunuch')
Plug('jiangmiao/auto-pairs')
Plug('preservim/nerdtree')

vim.call('plug#end')

---------------------------------------------------------------------------
-- Plugin config
---------------------------------------------------------------------------

require('plugins.cmp')
require('plugins.fzf')
require('plugins.lualine')
require('plugins.lsp')
require('plugins.onedark')
require('plugins.treesitter')
