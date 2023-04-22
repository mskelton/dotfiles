local M = {}

function M.apply_edits(result)
	for _, r in pairs(result or {}) do
		if r.edit then
			vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
		else
			vim.lsp.buf.execute_command(r.command)
		end
	end
end

function M.make_params(code_action)
	local position_params = vim.lsp.util.make_range_params()
	position_params.context = { only = { code_action } }
	return position_params
end

function M.run_code_action(code_action)
	---@diagnostic disable-next-line: missing-parameter
	local result = vim.lsp.buf_request_sync(
		0,
		"textDocument/codeAction",
		M.make_params(code_action)
	)

	for _, res in pairs(result or {}) do
		M.apply_edits(res.result)
	end
end

--- BUG: Vim doesn't properly restore the cursor position after formatting.
--- https://github.com/neovim/neovim/issues/14645
--- @param bufnr number
M.format = function(bufnr)
	local windows = vim.fn.win_findbuf(bufnr)
	local ns = vim.api.nvim_create_namespace("lsp_format")
	local marks = {}

	for _, window in ipairs(windows) do
		local line, col = unpack(vim.api.nvim_win_get_cursor(window))
		marks[window] = vim.api.nvim_buf_set_extmark(bufnr, ns, line - 1, col, {})
	end

	-- Run the formatter
	vim.lsp.buf.format()

	for _, window in ipairs(windows) do
		local mark = marks[window]
		local max_line_index = vim.api.nvim_buf_line_count(bufnr) - 1
		local line, col =
			unpack(vim.api.nvim_buf_get_extmark_by_id(bufnr, ns, mark, {}))

		if line and col and line <= max_line_index then
			vim.api.nvim_win_set_cursor(window, { line + 1, col })
		end
	end

	vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
end

return M
