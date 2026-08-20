local ensure_installed = {
	"awk",
	"bash",
	"c",
	"comment",
	"cpp",
	"css",
	"devicetree",
	"fish",
	"gitattributes",
	"gitignore",
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
	"kotlin",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"query",
	"regex",
	"rust",
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
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
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
			require("nvim-treesitter").install(ensure_installed)

			--- Highlighting is no longer enabled by nvim-treesitter itself.
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
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

			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local textobjects = {
				af = "@function.outer",
				["if"] = "@function.inner",
				ac = "@comment.outer",
				ic = "@comment.outer",
				ad = "@decl.outer",
				id = "@decl.inner",
				aT = "@test.outer",
				iT = "@test.inner",
				at = "@tag.outer",
				it = "@tag.inner",
				am = "@parameter.outer",
				im = "@parameter.inner",
			}

			for mapping, query in pairs(textobjects) do
				vim.keymap.set({ "x", "o" }, mapping, function()
					select.select_textobject(query, "textobjects")
				end)
			end
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
