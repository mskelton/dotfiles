local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettierd.with({
			env = {
				PRETTIERD_LOCAL_PRETTIER_ONLY = true,
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"markdown.mdx",
				"graphql",
				"handlebars",
				"svg",
				"svelte",
			},
		}),
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.formatting.rustfmt,
		helpers.make_builtin({
			name = "dtsfmt",
			meta = {
				url = "https://github.com/mskelton/dtsfmt",
				description = "Auto formatter for device tree files",
				notes = {},
			},
			method = methods.internal.FORMATTING,
			filetypes = { "dts" },
			generator_opts = {
				command = "dtsfmt",
				args = { "--emit=stdout" },
				to_stdin = true,
			},
			factory = helpers.formatter_factory,
		}),
	},
})
