local M = {}

M.register_handlers = function()
	local find_references = vim.lsp.handlers["textDocument/references"]

	-- Language servers often include the current line in find references calls
	-- which is really unnecessary since I know there is a reference where my
	-- cursor is. This filters out the current line before sending the results to
	-- the quickfix list.
	vim.lsp.handlers["textDocument/references"] = vim.lsp.with(find_references, {
		on_list = function(args)
			local cursor_line = unpack(vim.api.nvim_win_get_cursor(0))
			local items = vim.tbl_filter(function(item)
				return item.lnum ~= cursor_line
			end, args.items)

			if vim.tbl_isempty(items) then
				-- Since we filter the results after the internal LSP no-results check
				-- we have to re-check if there are no results.
				vim.notify("No references found")
			else
				vim.fn.setqflist(
					{},
					" ",
					{ title = args.title, items = items, context = args.ctx }
				)

				vim.api.nvim_command("botright copen")
			end
		end,
	})

	--- Disable warnings about dynamic registration. I really don't care.
	--- @diagnostic disable-next-line: duplicate-set-field
	vim.lsp.handlers["client/registerCapability"] = function()
		return { result = nil, error = nil }
	end
end

return M
