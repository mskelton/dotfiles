local utils = require("lsp.utils")
local group = vim.api.nvim_create_augroup("lsp", {})

local formatters = {
	"clangd",
	"eslint",
	"gopls",
	"null-ls",
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

		-- Disable semantic tokens for now. It's not quite ready for prime time.
		client.server_capabilities.semanticTokensProvider = nil

		if client.name == "tsserver" then
			-- Organize imports for TypeScript files. Unfortunate to have to do two
			-- separate actions, but unfortunately it's the way the language server is
			-- setup.
			vim.keymap.set("n", "go", "<cmd>TypescriptAddMissingImports<cr>", opts)
			vim.keymap.set("n", "gO", "<cmd>TypescriptRemoveUnused<cr>", opts)

			-- Rename file keymap similar to rename variable
			vim.keymap.set("n", "<leader>rf", "<cmd>TypescriptRenameFile<cr>", opts)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function(opts)
		local clients = vim.lsp.get_active_clients({ bufnr = opts.buf })

		-- Only run formatting if there are connected LSP clients
		if vim.tbl_count(clients) ~= 0 then
			vim.lsp.buf.format()
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*.go",
	callback = function()
		utils.run_code_action("source.organizeImports")
	end,
})
