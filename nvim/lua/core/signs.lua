local M = {}

M.signs = { Error = "", Warn = "", Hint = "", Info = "" }

M.setup = function()
	for key, value in pairs(M.signs) do
		local hl = "DiagnosticSign" .. key
		vim.fn.sign_define(hl, { texthl = hl, text = value, numhl = "" })
	end
end

return M
