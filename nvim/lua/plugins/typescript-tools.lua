local utils = require("core.utils")

return {
	"pmizio/typescript-tools.nvim",
	enabled = false,
	event = "BufReadPre",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({
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
				tsserver_plugins = {},
				tsserver_file_preferences = {
					autoImportFileExcludePatterns = {
						"**/@mobily/ts-belt",
						"**/carbon-components-react",
						"**/react-aria-components",
					},
				},
			},
		})

		vim.api.nvim_create_user_command("TSToolsRenameFile", function()
			local clients = vim.lsp.get_active_clients()
			local client = vim.tbl_filter(function(client)
				return client.name == "typescript-tools"
			end, clients)[1]

			if client == nil then
				return
			end

			local source_file = vim.api.nvim_buf_get_name(0)
			local source_dir = vim.fn.fnamemodify(source_file, ":p:h") .. "/"

			vim.ui.input({
				prompt = "Rename",
				completion = "file",
				default = source_dir,
			}, function(target_file)
				if target_file == nil then
					return
				end

				vim.lsp.buf_request(0, "workspace/willRenameFiles", {
					files = {
						{
							oldUri = vim.uri_from_fname(source_file),
							newUri = vim.uri_from_fname(target_file),
						},
					},
				})
			end)
		end, {})
	end,
}
