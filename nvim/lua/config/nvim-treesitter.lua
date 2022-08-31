return function()
	require("nvim-treesitter.configs").setup({
		autotag = {
			enable = true,
		},
		ensure_installed = {
			"bash",
			"css",
			"dockerfile",
			"fish",
			"go",
			"gomod",
			"gowork",
			"graphql",
			"html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"markdown",
			"python",
			"regex",
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
				},
			},
		},
	})

	require("modules.treesitter").directives()
	require("modules.treesitter").queries()
end
