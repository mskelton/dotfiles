return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/playground",
			"RRethy/nvim-treesitter-endwise",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local parser_config =
				require("nvim-treesitter.parsers").get_parser_configs()

			-- Use the local version of a parser if available, otherwise download the
			-- remote version.
			local function local_parser(parser, base_url)
				local dir = vim.fn.expand("~/dev/" .. parser)

				if vim.fn.isdirectory(dir) == 1 then
					return dir
				end

				return base_url .. parser
			end

			parser_config.mql5 = {
				install_info = {
					url = local_parser(
						"tree-sitter-mql5",
						"https://github.com/mskelton/"
					),
					branch = "main",
					files = { "src/parser.c", "src/scanner.cc" },
					generate_requires_npm = true,
				},
				maintainers = { "@mskelton" },
			}

			parser_config.styled = {
				install_info = {
					url = local_parser(
						"tree-sitter-styled",
						"https://github.com/mskelton/"
					),
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
					"mql5",
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

			-- Custom predicate to improve highlighting of languages injected into JS
			-- tagged template literals.
			vim.treesitter.query.add_predicate(
				"injected?",
				function(match, _, bufnr, pred)
					local node = match[pred[2]]
					local ancestor_types = { unpack(pred, 3) }

					if not node then
						return false
					end

					local parent = node:parent()
					if parent:type() == "call_expression" then
						local func = parent:field("function")[1]
						local name_node = nil

						if func:type() == "identifier" then
							name_node = func
						elseif func:type() == "call_expression" then
							name_node = func:field("function")[1]
						elseif func:type() == "member_expression" then
							name_node = func:field("object")[1]
						end

						return name_node ~= nil
							and vim.tbl_contains(
								ancestor_types,
								vim.treesitter.get_node_text(name_node, bufnr)
							)
					end

					return false
				end,
				true
			)
		end,
	},
}
