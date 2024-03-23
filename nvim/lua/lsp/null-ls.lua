local null_ls = require("null-ls")

null_ls.setup({
	sources = {
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
				"sql",
				"svg",
				"svelte",
			},
		}),
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.dtsfmt,
		null_ls.builtins.formatting.swiftformat,
		null_ls.builtins.formatting.mdformat.with({
			condition = function(utils)
				return utils.root_has_file({ ".mdformat.toml" })
			end,
		}),
	},
})
