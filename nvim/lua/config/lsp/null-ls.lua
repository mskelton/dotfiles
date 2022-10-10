local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd.with({
			condition = function(utils)
				return utils.root_has_file({
					-- https://prettier.io/docs/en/configuration.html
					".prettierrc",
					".prettierrc.json",
					".prettierrc.yml",
					".prettierrc.yaml",
					".prettierrc.json5",
					".prettierrc.js",
					".prettierrc.cjs",
					".prettier.config.js",
					".prettier.config.cjs",
					".prettierrc.toml",
				})
			end,
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.swiftformat,
	},
})
