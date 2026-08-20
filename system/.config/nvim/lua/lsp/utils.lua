local M = {}

function M.apply_edits(result)
	for _, r in pairs(result or {}) do
		if r.edit then
			vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
		elseif r.command then
			vim.lsp.buf.execute_command(r.command)
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
--- @param client vim.lsp.Client|nil
function M.run_code_action(bufnr, code_action, client)
	--- If a `client` was specified, then we need to use the client's
	--- `request_sync` function instead of the default `buf_request_sync`.
	if client then
		local result = client.request_sync(
			"textDocument/codeAction",
			M.make_params(bufnr, code_action),
			nil,
			bufnr
		)

		if result then
			M.apply_edits(result.result)
		end
	else
		local results = vim.lsp.buf_request_sync(
			bufnr,
			"textDocument/codeAction",
			M.make_params(bufnr, code_action)
		)

		for _, result in pairs(results or {}) do
			M.apply_edits(result.result)
		end
	end
end

return M
