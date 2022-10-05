if vim.g.vscode == nil then
	require("core.globals")
	require("core.options")
	require("core.filetypes")
	require("core.signs")
	require("core.commands")
	require("core.keymap")
	require("core.autocmd")
	require("plugins")
else
	require("vscode")
end
