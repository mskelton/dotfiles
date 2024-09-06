local M = {}

function M.apply_edits(result)
	for _, r in pairs(result or {}) do
		if r.edit then
			vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
		elseif r.command then
			vim.lsp.buf.execute_command(r.command)
		else
			vim.notify("No edits or commands to apply", vim.log.levels.WARN)
		end
	end
end

--- Make params for a code action
--- @param bufnr number
--- @param code_action string
function M.make_params(bufnr, code_action)
	local position_params = vim.lsp.util.make_range_params()

	position_params.context = {
		diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
		triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
		only = { code_action },
	}

	return position_params
end

--- Run a code action synchronously. This is useful for running code actions
--- on save.
--- @param bufnr number
--- @param code_action string
function M.run_code_action(bufnr, code_action)
	local result = vim.lsp.buf_request_sync(
		bufnr,
		"textDocument/codeAction",
		M.make_params(bufnr, code_action)
	)

	for _, res in pairs(result or {}) do
		M.apply_edits(res.result)
	end
end

return M
