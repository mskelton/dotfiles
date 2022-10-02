local signs = {
	DiagnosticSignError = "",
	DiagnosticSignWarn = "",
	DiagnosticSignHint = "",
	DiagnosticSignInfo = "",
}

for key, value in pairs(signs) do
	vim.fn.sign_define(key, { texthl = key, text = value, numhl = "" })
end
