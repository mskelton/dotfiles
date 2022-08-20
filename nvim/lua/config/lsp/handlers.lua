local utils = require("config.lsp.utils")

local M = {}

M.setup = function()
	local signs = {
		DiagnosticSignError = "",
		DiagnosticSignWarn = "",
		DiagnosticSignHint = "",
		DiagnosticSignInfo = "",
	}

	for key, value in pairs(signs) do
		vim.fn.sign_define(key, { texthl = key, text = value, numhl = "" })
	end
end

-- Use an on_attach function to only map keybindings to LSP commands after the
-- language server attaches to the current buffer.
M.on_attach = function(client, bufnr)
	local function map(key, cmd)
		local opts = { buffer = bufnr, silent = true }
		vim.keymap.set("n", key, cmd, opts)
	end

	local function map_fn(key, cmd)
		map(key, "<cmd>lua " .. cmd .. "<cr>")
	end

	map_fn("K", "vim.lsp.buf.hover()")
	map_fn("gd", "vim.lsp.buf.definition()")
	map_fn("gD", "vim.lsp.buf.declaration()")
	map_fn("gi", "vim.lsp.buf.implementation()")
	map_fn("gr", "vim.lsp.buf.references()")
	map_fn("<leader>ca", "vim.lsp.buf.code_action()")
	map_fn("<leader>rn", "vim.lsp.buf.rename()")

	-- Unimpaired style diagnostic navigation
	map_fn("[d", "vim.diagnostic.goto_prev()")
	map_fn("]d", "vim.diagnostic.goto_next()")

	if client.name == "eslint" then
		client.resolved_capabilities.document_formatting = true
		client.resolved_capabilities.document_range_formatting = true
	end

	if client.name == "stylelint_lsp" then
		client.resolved_capabilities.document_formatting = true
	end

	if client.name == "nemneko_lua" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false

		-- Organize everything at once. Potentially dangerous if edits conflict,
		-- but that happens infrequent enough that a single atomic update for
		-- everything is worth it.
		map("go", function()
			utils.run_code_action(bufnr, "source.addMissingImports")
			utils.run_code_action(bufnr, "source.removeUnused")
			utils.run_code_action(bufnr, "source.fixAll")
		end)
	end
end

-- Update the LSP capabilities to support completions.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

function M.enable_format_on_save()
	local group = vim.api.nvim_create_augroup("FormatOnSave", {})

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = "*",
		callback = function()
			vim.lsp.buf.formatting_seq_sync(nil, 2000, {
				"eslint",
				"stylelint_lsp",
				"null-ls",
			})
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = "*.go",
		callback = function()
			utils.run_code_action_sync(0, "source.organizeImports")
		end,
	})
end

return M
