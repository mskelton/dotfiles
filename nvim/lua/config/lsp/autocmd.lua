local utils = require("config.lsp.utils")
local group = vim.api.nvim_create_augroup("lsp", {})

local formatters = {
	"eslint",
	"gopls",
	"null-ls",
	"stylelint_lsp",
}

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

		-- Only enable formatting for specific LSP's. Many LSPs that have built-in
		-- formatting don't have robust enough formatting (e.g. tsserver is not as
		-- complete as Prettier).
		local format = vim.tbl_contains(formatters, client.name)
		client.server_capabilities.documentFormattingProvider = format
		client.server_capabilities.documentRangeFormattingProvider = format

		-- Organize imports for TypeScript files. Unfortunate to have to do two
		-- separate actions, but unfortunately it's the way the language server is
		-- setup.
		if client.name == "tsserver" then
			vim.keymap.set("n", "go", function()
				utils.run_code_action("source.addMissingImports.ts")
			end, opts)

			vim.keymap.set("n", "gO", function()
				utils.run_code_action("source.removeUnused.ts")
			end, opts)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*.go",
	callback = function()
		utils.run_code_action("source.organizeImports")
	end,
})
