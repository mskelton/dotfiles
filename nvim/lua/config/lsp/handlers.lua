local M = {}

M.register_handlers = function()
	local find_references = vim.lsp.handlers["textDocument/references"]

	-- Language servers often include the current line in find references calls
	-- which is really unnecessary since I know there is a reference where my
	-- cursor is. This filters out the current line before sending the results to
	-- the quick fix list.
	vim.lsp.handlers["textDocument/references"] = vim.lsp.with(find_references, {
		on_list = function(args)
			local cursorLine = unpack(vim.api.nvim_win_get_cursor(0))
			local items = vim.tbl_filter(function(item)
				return item.lnum ~= cursorLine
			end, args.items)

			vim.fn.setqflist(
				{},
				" ",
				{ title = args.title, items = items, context = args.ctx }
			)

			vim.api.nvim_command("botright copen")
		end,
	})
end

return M
