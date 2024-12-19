return {
	"pmizio/typescript-tools.nvim",
	enabled = false,
	event = "BufReadPre",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local api = require("typescript-tools.api")
		local utils = require("core.utils")

		require("typescript-tools").setup({
			on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "go", function()
					api.add_missing_imports(false)
				end, opts)

				vim.keymap.set("n", "gO", function()
					api.remove_unused_imports(false)
				end, opts)

				vim.keymap.set("n", "<leader>rf", function()
					api.rename_file(false)
				end, opts)

				--- TODO: Fix these
				--- vim.keymap.set("n", "<leader>uab", function()
				--- 	ts_utils.add_braces_to_arrow_function(bufnr)
				--- end, opts)
				---
				--- vim.keymap.set("n", "<leader>urb", function()
				--- 	ts_utils.remove_braces_from_arrow_function(bufnr)
				--- end, opts)
				---
				--- vim.keymap.set("n", "<leader>unf", function()
				--- 	ts_utils.convert_to_named_function(bufnr)
				--- end, opts)
			end,
			handlers = {
				--- Filter out certain paths from the results that are 99% of the time
				--- false positive results for my use case. If I explicitly jump to
				--- them, go there, otherwise ignore them.
				["textDocument/definition"] = function(_, result, ...)
					if vim.islist(result) then
						local ignored_paths = {
							"react/index.d.ts",
							"react/ts5.0/index.d.ts",
							"tailwind-variants/dist/index.d.ts",
							"styled-components/dist/types.d.ts",
						}

						for key, value in ipairs(result) do
							for _, ignored_path in pairs(ignored_paths) do
								--- If an ignored path is the first result, keep it as it's
								--- likely the intended path.
								if
									key ~= 1 and utils.ends_with(value.targetUri, ignored_path)
								then
									table.remove(result, key)
								end
							end
						end
					end

					--- Defer to the built-in handler after filtering the results
					vim.lsp.handlers["textDocument/definition"](_, result, ...)
				end,
				--- Disable specific diagnostics that I don't care about. TypeScript has
				--- some super opinionated diagnostics that don't always make sense.
				["textDocument/publishDiagnostics"] = api.filter_diagnostics({
					--- File is a CommonJS module; it may be converted to an ES module
					80001,
					-- This may be converted to an async function
					80006,
				}),
			},
			settings = {
				publish_diagnostic_on = "change",
				tsserver_file_preferences = {
					autoImportFileExcludePatterns = {
						"**/.next/*",
						"**/postcss",
						"**/react-aria-components",
						"**/react-router",
					},
				},
				tsserver_max_memory = 8192,
			},
		})
	end,
}
