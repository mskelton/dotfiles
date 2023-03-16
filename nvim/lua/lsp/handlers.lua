local M = {}

local function noop()
	return { result = nil, error = nil }
end

M.register_handlers = function()
	local find_references = vim.lsp.handlers["textDocument/references"]
	local definition = vim.lsp.handlers["textDocument/definition"]

	-- When there are multiple results on the same line for a definition, only
	-- show the first one. This prevents many times where going to definition
	-- opens a quickfix list when it really doesn't need to.
	vim.lsp.handlers["textDocument/definition"] = function(_, result, ...)
		if vim.tbl_islist(result) then
			local seen = {}

			for index, value in ipairs(result) do
				local key = value.targetUri
					.. ":"
					.. value.targetSelectionRange.start.line

				if seen[key] then
					table.remove(result, index)
				else
					seen[key] = true
				end
			end
		end

		-- Defer to the built-in handler after filtering the results
		definition(_, result, ...)
	end

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
	vim.lsp.handlers["client/registerCapability"] = noop
	vim.lsp.handlers["client/unregisterCapability"] = noop
end

return M
