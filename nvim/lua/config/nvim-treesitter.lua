return function()
	require("nvim-treesitter.configs").setup({
		autotag = { enable = true },
		endwise = { enable = true },
		ensure_installed = {
			"bash",
			"css",
			"comment",
			"dockerfile",
			"fish",
			"gitattributes",
			"gitignore",
			"go",
			"gomod",
			"gowork",
			"graphql",
			"help",
			"html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"sql",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
		sync_install = false,
		highlight = { enable = true },
		playground = { enable = true },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@comment.outer",
					["ic"] = "@comment.outer",
					["ad"] = "@declaration.outer",
					["id"] = "@declaration.inner",
					["as"] = "@statement.outer",
					["is"] = "@statement.inner",
				},
			},
		},
	})

	require("modules.treesitter").directives()
	require("modules.treesitter").queries()
end
