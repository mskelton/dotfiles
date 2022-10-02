local utils = require("config.lsp.utils")
local group = vim.api.nvim_create_augroup("lsp", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local opts = { buffer = bufnr, silent = true }

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Unimpaired style diagnostic navigation
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		-- While I'll likely continuing using gd for go to definition, configuring
		-- tagfunc is no big deal and makes that work as well.
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		if client.name == "eslint" or client.name == "stylelint_lsp" then
			client.server_capabilities.documentFormattingProvider = true
			client.server_capabilities.documentRangeFormattingProvider = true
		end

		if client.name == "jsonls" then
			client.server_capabilities.documentFormattingProvider = false
		end

		if client.name == "tsserver" then
			client.server_capabilities.documentFormattingProvider = false

			vim.keymap.set("n", "go", function()
				utils.run_code_action_sync(bufnr, "source.addMissingImports")
			end, opts)

			vim.keymap.set("n", "gO", function()
				utils.run_code_action_sync(bufnr, "source.removeUnused")
			end, opts)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function()
		local clients = { "eslint", "stylelint_lsp", "null-ls" }

		vim.lsp.buf.format({
			filter = function(client)
				return vim.tbl_contains(clients, client.name)
			end,
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
