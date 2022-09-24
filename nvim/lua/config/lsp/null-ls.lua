local M = {}

M.setup = function()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.prettierd,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.swiftformat,
		},
	})
end

return M
