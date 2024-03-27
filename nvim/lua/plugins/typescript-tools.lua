local utils = require("core.utils")
--- local npm = require("utils.npm")

return {
	"pmizio/typescript-tools.nvim",
	--- enabled = false,
	event = "BufReadPre",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({
			on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, silent = true }

				--- Organize imports for TypeScript files. Unfortunate to have to do two
				--- separate actions, but unfortunately it's the way the language server is
				--- setup.
				vim.keymap.set("n", "go", "<cmd>TSToolsAddMissingImports<cr>", opts)
				vim.keymap.set("n", "gO", "<cmd>TSToolsRemoveUnusedImports<cr>", opts)

				--- Rename file keymap similar to rename variable
				vim.keymap.set("n", "<leader>rf", "<cmd>TSToolsRenameFile<cr>", opts)
			end,
			handlers = {
				-- Filter out certain paths from the results that are 99% of the time
				-- false positive results for my use case. If I explicitly jump to
				-- them, go there, otherwise ignore them.
				["textDocument/definition"] = function(_, result, ...)
					if vim.tbl_islist(result) then
						local ignored_paths = {
							"react/index.d.ts",
							"react/ts5.0/index.d.ts",
							"tailwind-variants/dist/index.d.ts",
						}

						for key, value in ipairs(result) do
							for _, ignored_path in pairs(ignored_paths) do
								-- If an ignored path is the first result, keep it as it's
								-- likely the intended path.
								if
									key ~= 1 and utils.ends_with(value.targetUri, ignored_path)
								then
									table.remove(result, key)
								end
							end
						end
					end

					-- Defer to the built-in handler after filtering the results
					vim.lsp.handlers["textDocument/definition"](_, result, ...)
				end,
			},
			settings = {
				publish_diagnostic_on = "change",
				tsserver_plugins = {
					--- {
					--- 	name = "typescript-styled-plugin",
					--- 	location = npm.mason_lib("typescript-styled-plugin"),
					--- 	config = {
					--- 		validate = false,
					--- 		emmet = { showExpandedAbbreviation = "never" },
					--- 	},
					--- },
				},
				tsserver_file_preferences = {
					autoImportFileExcludePatterns = {
						"**/.next/*",
						"**/@federato/deprecated-athena",
						"**/@mobily/ts-belt",
						"**/carbon-components-react",
						"**/postcss",
						"**/react-aria-components",
					},
				},
			},
		})
	end,
}
