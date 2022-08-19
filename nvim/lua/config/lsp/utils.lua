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

function M.run_code_action(bufnr, code_action)
	vim.lsp.buf_request(
		bufnr,
		"textDocument/codeAction",
		M.make_params(code_action),
		function(err, result)
			M.apply_edits(result)
		end
	)
end

function M.run_code_action_sync(bufnr, code_action)
	local result = vim.lsp.buf_request_sync(
		bufnr,
		"textDocument/codeAction",
		M.make_params(code_action)
	)

	for _, res in pairs(result or {}) do
		M.apply_edits(res.result)
	end
end

return M
