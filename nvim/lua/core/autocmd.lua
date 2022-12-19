vim.cmd([[

" Disable continuation comments when using o/O. CR will still add the
" comment leader.
augroup disable_continuation_comments
  au!
  au BufEnter * set formatoptions-=c | set formatoptions-=o
augroup END

augroup auto_source_dotfiles
  au!
  au BufWritePost */nvim/lua/core/*.lua source <afile>
augroup END

augroup markdown_spell_check
  au!
  au FileType markdown setlocal spell spelllang=en_us
augroup END

augroup zet_template
  au!
  au BufNewFile */zettels/*.md 0r ~/.config/nvim/templates/zet.md
augroup END

augroup incsearch_hl
  au!
  au CmdlineEnter /,\? :set hlsearch
  au CmdlineLeave /,\? :set nohlsearch
augroup END

augroup keymap_nowrap
  au!
  au FileType dts set nowrap
augroup END

augroup auto_mkdir
  au!
  au BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

augroup highlight_on_yank
  au!
  au TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

]])

-- Enable spell checking only when Treesitter is enabled in the current buffer.
-- I set up spell checking this way as I only want spell checking in comments.
local spell_check = vim.api.nvim_create_augroup("treesitter_spell_check", {})
vim.api.nvim_create_autocmd("BufEnter", {
	group = spell_check,
	callback = function()
		local highlighter = require("vim.treesitter.highlighter")
		local utils = require("core.utils")
		local buf = vim.api.nvim_get_current_buf()

		---@diagnostic disable-next-line: assign-type-mismatch
		vim.opt_local.spell = utils.to_bool(highlighter.active[buf])
	end,
})
