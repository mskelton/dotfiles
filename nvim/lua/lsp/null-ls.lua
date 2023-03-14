local null_ls = require("null-ls")

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
			},
		}),
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
	},
})
