vim.cmd([[

augroup mskelton
  au!

  " Disable continuation comments when using o/O. CR will still add the
  " comment leader.
  au BufEnter * set formatoptions-=c | set formatoptions-=o

  " Enable search highlighting while searching
  au CmdlineEnter /,\? :set hlsearch
  au CmdlineLeave /,\? :set nohlsearch

  " Automatically restart prettierd when .prettierc is saved. This helps
  " especially when creating new Prettier config files which usually fails to
  " be loaded by prettierd.
  au BufWritePost .prettierrc,.prettierignore,prettier.config.* silent !pkill prettierd

  " Binary file template
  au BufNewFile *.sh 0r ~/.skeletons/bin
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
