local utils = require("lsp.utils")
local group = vim.api.nvim_create_augroup("lsp", {})

--- When there are warnings/errors, skip info/hint diagnostics
--- @param client table
--- @param bufnr number
local function get_diagnostic_opts(client, bufnr)
	--- rust-analyzer is a special case. It adds multiple diagnostics for the same
	--- error to identify both the error and possible cause sites. As such,
	--- including all diagnostics is important for proper navigation.
	if client.name == "rust_analyzer" then
		return {}
	end

	local diagnostics = vim.diagnostic.get(bufnr)
	local severe = vim.tbl_filter(function(diagnostic)
		return diagnostic.severity == vim.diagnostic.severity.WARN
			or diagnostic.severity == vim.diagnostic.severity.ERROR
	end, diagnostics)

	if vim.tbl_isempty(severe) then
		return {}
	else
		return { severity = { min = vim.diagnostic.severity.WARN } }
	end
end

local formatters = {
	"biome",
	"clangd",
	"dartls",
	"eslint",
	"gopls",
	"null-ls",
	"ocamllsp",
	"prismals",
	"taplo",
}

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local opts = { buffer = bufnr, silent = true }

		--- Shouldn't happen, but just in case
		if client == nil then
			return
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action({
				--- Filter unwanted code actions
				filter = function(action)
					return action.title ~= "Move to a new file"
						and action.title ~= "Generate 'get' and 'set' accessors"
				end,
			})
		end, opts)

		--- Enable inlay hints if the server (and Neovim) supports it
		if
			client.server_capabilities.inlayHintProvider and vim.lsp.buf.inlay_hint
		then
			vim.lsp.buf.inlay_hint(bufnr, true)
		end

		--- Unimpaired style diagnostic navigation for warnings and errors. Info and
		--- hints are ignored.
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev(get_diagnostic_opts(client, bufnr))
		end, opts)

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next(get_diagnostic_opts(client, bufnr))
		end, opts)

		--- While I'll likely continuing using gd for go to definition, configuring
		--- tagfunc is no big deal and makes that work as well.
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		--- Only enable formatting for specific LSP's. Many LSPs that have built-in
		--- formatting don't have robust enough formatting (e.g. tsserver is not as
		--- complete as Prettier).
		local format = vim.tbl_contains(formatters, client.name)
		client.server_capabilities.documentFormattingProvider = format
		client.server_capabilities.documentRangeFormattingProvider = format

		--- Disable semantic tokens for now. It's not quite ready for prime time.
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

--- Register a autocmd that runs on BufWritePre for a given pattern
--- @param pattern string
--- @param callback function
local function on_write(pattern, callback)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		pattern = pattern,
		callback = callback,
	})
end

--- Register a autocmd that runs code action(s) on BufWritePre for a given pattern
--- @param pattern string
--- @param code_actions table
local function code_actions_on_write(pattern, code_actions)
	on_write(pattern, function(opts)
		for _, value in ipairs(code_actions) do
			utils.run_code_action(opts.buf, value)
		end
	end)
end

on_write("*", function(opts)
	local clients = vim.lsp.get_clients({ bufnr = opts.buf })

	--- Only run formatting if there are connected LSP clients
	if vim.tbl_count(clients) ~= 0 then
		vim.lsp.buf.format({ bufnr = opts.buf })
	end
end)

code_actions_on_write("*.dart", { "source.fixAll" })
code_actions_on_write("*.go", { "source.organizeImports" })
--- TODO
--- code_actions_on_write({ "*.go", "*.rs" }, { "source.organizeImports" })
