return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		cmd = {
			"TSInstall",
			"TSInstallSync",
			"TSInstallInfo",
			"TSUpdate",
			"TSUpdateSync",
			"TSUninstall",
			"TSBufEnable",
			"TSBufDisable",
			"TSBufToggle",
			"TSEnable",
			"TSDisable",
			"TSToggle",
			"TSModuleInfo",
			"TSEditQuery",
			"TSEditQueryUserAfter",
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = { enable = true },
				endwise = { enable = true },
				ensure_installed = {
					"awk",
					"bash",
					"css",
					"cpp",
					"comment",
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
					"prisma",
					"python",
					"query",
					"regex",
					"sql",
					"swift",
					"svelte",
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
			{
				"<leader>th",
				"<cmd>TSHighlightCapturesUnderCursor<cr>",
				desc = "Highlight captures under cursor",
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
