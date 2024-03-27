return {
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		lazy = false,
		enabled = false,
		config = function()
			require("noice").setup({
				cmdline = { enabled = false },
				messages = { enabled = false },
				notify = { enabled = false },
				lsp = {
					progress = {
						enabled = false,
					},
					hover = {
						enabled = true,
					},
					message = {
						enabled = false,
					},
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
		end,
	},
}
