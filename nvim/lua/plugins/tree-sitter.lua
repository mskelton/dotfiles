return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		cmd = {
			"TSBufDisable",
			"TSBufEnable",
			"TSBufToggle",
			"TSDisable",
			"TSEditQuery",
			"TSEditQueryUserAfter",
			"TSEnable",
			"TSInstall",
			"TSInstallInfo",
			"TSInstallSync",
			"TSModuleInfo",
			"TSToggle",
			"TSUninstall",
			"TSUpdate",
			"TSUpdateSync",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nushell/tree-sitter-nu",
		},
		keys = {
			{
				"<leader>th",
				"<cmd>Inspect<cr>",
				desc = "Highlight captures under cursor",
			},
		},
		config = function()
			require("nvim-treesitter.parsers").get_parser_configs().sed = {
				install_info = {
					url = "https://github.com/mskelton/tree-sitter-sed",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetype = "sed",
			}

			require("nvim-treesitter.configs").setup({
				endwise = { enable = true },
				ensure_installed = {
					"awk",
					"bash",
					"c",
					"comment",
					"cpp",
					"css",
					"dart",
					"devicetree",
					"dockerfile",
					"fish",
					"gitattributes",
					"gitignore",
					"glimmer",
					"go",
					"gomod",
					"gowork",
					"graphql",
					"html",
					"http",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"kotlin",
					"lua",
					"markdown",
					"markdown_inline",
					"nu",
					"ocaml",
					"prisma",
					"python",
					"query",
					"regex",
					"rust",
					"sed",
					"sql",
					"styled",
					"svelte",
					"swift",
					"terraform",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
					"zig",
				},
				sync_install = false,
				highlight = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						disable = { "dart", "zig" },
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@comment.outer",
							["ic"] = "@comment.outer",
							["ad"] = "@decl.outer",
							["id"] = "@decl.inner",
							["aT"] = "@test.outer",
							["iT"] = "@test.inner",
							["at"] = "@tag.outer",
							["it"] = "@tag.inner",
							["am"] = "@parameter.outer",
							["im"] = "@parameter.inner",
						},
					},
				},
			})

			--- Custom predicate to improve highlighting of languages injected into JS
			--- tagged template literals.
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
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
		},
		opts = {
			enable_close_on_slash = false,
		},
		config = true,
	},
	{
		"RRethy/nvim-treesitter-endwise",
		ft = { "bash", "lua" },
	},
}
