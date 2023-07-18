local utils = require("core.utils")

return {
	"jose-elias-alvarez/typescript.nvim",
	event = "BufReadPre",
	config = {
		server = {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
			init_options = {
				preferences = {
					autoImportFileExcludePatterns = {
						"**/@mobily/ts-belt",
						"**/carbon-components-react",
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
