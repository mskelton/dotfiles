return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
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
			{
				"nvim-treesitter/nvim-treesitter-context",
				enabled = false,
				config = true,
			},
		},
		keys = {
			{
				"<leader>th",
				"<cmd>Inspect<cr>",
				desc = "Highlight captures under cursor",
			},
		},
		config = function()
			local parser_config =
				require("nvim-treesitter.parsers").get_parser_configs()

			-- TODO: Temporary until https://github.com/UserNobody14/tree-sitter-dart/issues/46 is fixed
			parser_config.dart.install_info.revision =
				"8aa8ab977647da2d4dcfb8c4726341bee26fbce4"

			require("nvim-treesitter.configs").setup({
				autotag = { enable = true },
				endwise = { enable = true },
				ensure_installed = {
					"awk",
					"bash",
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
					"java",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"kotlin",
					"lua",
					"markdown",
					"markdown_inline",
					"prisma",
					"python",
					"query",
					"regex",
					"rust",
					"sql",
					"svelte",
					"swift",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
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
	{
		"nvim-treesitter/playground",
		cmd = {
			"TSHighlightCapturesUnderCursor",
			"TSPlaygroundToggle",
		},
		keys = {
			{
				"<leader>tp",
				"<cmd>TSPlaygroundToggle<cr>",
				desc = "Toggle treesitter playground",
			},
		},
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
	},
	{
		"RRethy/nvim-treesitter-endwise",
		ft = { "bash", "lua" },
	},
}
