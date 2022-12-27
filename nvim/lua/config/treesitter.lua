return function()
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

	-- Use the local version of a parser if available, otherwise download the
	-- remote version.
	local function local_parser(parser, base_url)
		local dir = vim.fn.expand("~/dev/" .. parser)

		if vim.fn.isdirectory(dir) == 1 then
			return dir
		end

		return base_url .. parser
	end

	parser_config.styled = {
		install_info = {
			url = local_parser("tree-sitter-styled", "https://github.com/mskelton/"),
			branch = "main",
			files = { "src/parser.c", "src/scanner.c" },
			generate_requires_npm = true,
		},
		maintainers = { "@mskelton" },
	}

	require("nvim-treesitter.configs").setup({
		autotag = { enable = true },
		endwise = { enable = true },
		ensure_installed = {
			"bash",
			"css",
			"cpp",
			"comment",
			"devicetree",
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
			"styled",
			"swift",
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
					["aT"] = "@test.outer",
					["iT"] = "@test.inner",
				},
			},
		},
	})
end
