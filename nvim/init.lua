if vim.fn.exists("g:vscode") == 1 then
	require("vscode")
else
	require("core.options")
	require("core.filetypes")
	require("core.keymap")
	require("modules")
	require("core.autocmd")
end
