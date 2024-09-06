local utils = require("lsp.utils")
local async = require("lsp.typescript.async")
local rename = require("lsp.typescript.rename")
local errors = require("lsp.typescript.errors")

local M = {}

--- Get the vtsls client for the current buffer
--- @param bufnr number
local function get_client(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" })

	if clients and clients[1] then
		return clients[1]
	end
end

local function exec_command(bufnr, client, command, args)
	return async.request(client, "workspace/executeCommand", {
		command = command,
		arguments = args,
	}, bufnr)
end

--- Generate a command function for the vtsls client
--- @param name string
--- @param params function|nil
--- @param handler function|nil
local function gen_buf_command(name, params, handler)
	handler = handler or function() end

	return function(bufnr, res, rej)
		bufnr = bufnr or vim.api.nvim_get_current_buf()
		res = res or function() end
		rej = rej or errors.reject

		local client = get_client(bufnr)
		if not client then
			return rej("No client found")
		end

		async.exec(function()
			handler(
				exec_command(bufnr, client, name, params and params(bufnr, client))
			)
		end, res, rej)
	end
end

--- Generate a code action function
--- @param kind string
local function gen_code_action(kind)
	return function(bufnr)
		utils.run_code_action(bufnr, kind)
	end
end

--- Rename a file
--- @param bufnr number
--- @param res function|nil
--- @param rej function|nil
function M.rename_file(bufnr, res, rej)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	res = res or function() end
	rej = rej or errors.reject

	local old_name = vim.api.nvim_buf_get_name(bufnr)
	async.exec(function()
		local new_name = async.call(vim.ui.input, { default = old_name })
		if not new_name then
			return
		end
		async.async_call_err(rename, old_name, new_name)
	end, res, rej)
end

M.restart_tsserver = gen_buf_command("typescript.restartTsServer")
M.open_tsserver_log = gen_buf_command("typescript.openTsServerLog")
M.reload_projects = gen_buf_command("typescript.reloadProjects")

M.organize_imports = gen_code_action("source.organizeImports")
M.remove_unused_imports = gen_code_action("source.removeUnusedImports")
M.add_missing_imports = gen_code_action("source.addMissingImports.ts")
M.add_braces_to_arrow_function =
	gen_code_action("refactor.rewrite.arrow.braces.add")
M.remove_braces_from_arrow_function =
	gen_code_action("refactor.rewrite.arrow.braces.remove")
M.convert_to_named_function = gen_code_action("refactor.rewrite.function.named")

return M
