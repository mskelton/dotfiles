return {
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		lazy = false,
		enabled = false,
		config = function()
			require("noice").setup({
				cmdline = {
					enabled = false,
				},
				messages = {
					enabled = false,
					view = "cmdline",
				},
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				views = {
					mini = {
						position = {
							row = -2,
						},
					},
				},
			})

			-- Disable the Noice progress handle to disable messages from null-ls
			-- which are completely useless.
			vim.schedule(function()
				local original = vim.lsp.handlers["$/progress"]
				local null_ls_token = nil

				vim.lsp.handlers["$/progress"] = function(_, result, ctx, ...)
					-- Disable all messages from null-ls once we have the token
					if result.token == null_ls_token then
						return
					end

					-- Save the token for later
					if vim.lsp.get_client_by_id(ctx.client_id).name == "null-ls" then
						null_ls_token = result.token
						return
					end

					original(_, result, ctx, ...)
				end
			end)
		end,
	},
}
