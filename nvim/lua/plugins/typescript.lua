local utils = require("core.utils")
local npm = require("utils.npm")

--- Global plugins to be loaded when starting tsserver
local plugins = {
	{
		name = "typescript-styled-plugin",
		location = npm.mason_lib("typescript-styled-plugin"),
		config = {
			validate = false,
			emmet = { showExpandedAbbreviation = "never" },
		},
	},
}

return {
	"jose-elias-alvarez/typescript.nvim",
	event = "BufReadPre",
	--- enabled = false,
	--- enabled = env.is_work(),
	opts = {
		server = {
			on_attach = function(client, bufnr)
				for _, value in ipairs(plugins) do
					local params = {
						command = "_typescript.configurePlugin",
						arguments = { value.name, value.config },
					}

					client.request("workspace/executeCommand", params)
				end

				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "go", "<cmd>TypescriptAddMissingImports<cr>", opts)
				vim.keymap.set("n", "gO", "<cmd>TypescriptRemoveUnused<cr>", opts)
				vim.keymap.set("n", "<leader>rf", "<cmd>TypescriptRenameFile<cr>", opts)
				vim.keymap.set("n", "<leader>ob", function()
					vim.lsp.buf.code_action({
						apply = true,
						filter = function(action)
							return action.title == "Add braces to arrow function"
						end,
					})
				end, opts)
			end,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			--- cmd = {
			--- 	npm.global_bin("typescript-language-server"),
			--- 	"--stdio",
			--- },
			init_options = {
				plugins = vim.tbl_map(function(item)
					return {
						name = item.name,
						location = item.location,
					}
				end, plugins),
				preferences = {
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
		},
	},
}
