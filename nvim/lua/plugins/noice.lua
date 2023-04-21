return {
	"folke/noice.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	lazy = false,
	-- TODO
	enabled = false,
	config = {
		cmdline = {
			view = "cmdline",
		},
		messages = {
			enabled = false,
		},
		lsp = {
			progress = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
	},
}
