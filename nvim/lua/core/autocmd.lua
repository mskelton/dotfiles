vim.cmd([[

" Disable continuation comments when using o/O. CR will still add the
" comment leader.
augroup disable_continuation_comments
  au!
  au BufEnter * set formatoptions-=c | set formatoptions-=o
augroup END

" Automatically source core nvim config when saved.
augroup auto_source_dotfiles
  au!
  au BufWritePost */nvim/lua/core/*\(plugins\)\@<!.lua source <afile>
augroup END

augroup zet_template
  au!
  au BufNewFile */zettels/*.md 0r ~/.config/nvim/templates/zet.md
augroup END

" Enable search highlighting while searching
augroup incsearch_hl
  au!
  au CmdlineEnter /,\? :set hlsearch
  au CmdlineLeave /,\? :set nohlsearch
augroup END

" Automatically restart prettierd when .prettierc is saved. This helps
" especially when creating new Prettier config files which usually fails to
" be loaded by prettierd.
augroup restart_prettierd
  au!
  au BufWritePost .prettierrc,.prettierignore,prettier.config.* silent !pkill prettierd
augroup END

]])

-- Enable spell checking only when Treesitter is enabled in the current buffer.
-- I set up spell checking this way as I only want spell checking in comments.
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("mskelton_treesitter_spell_check", {}),
	callback = function()
		local highlighter = require("vim.treesitter.highlighter")
		local utils = require("core.utils")
		local buf = vim.api.nvim_get_current_buf()

		vim.opt_local.spell = utils.to_bool(highlighter.active[buf])
	end,
})
