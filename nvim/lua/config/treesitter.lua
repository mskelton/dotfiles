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

	local function is_one_line(range)
		return range[1] == range[3]
	end

	local function is_range_empty_or_invalid(range)
		return range[3] < range[1] or (is_one_line(range) and range[4] <= range[2])
	end

	local function make_subranges_between_children_like(node, predicate)
		local content = { { node:range() } }

		for child in node:iter_children() do
			if predicate(child) then
				local child_range = { child:range() }
				local last_content_range = content[#content]
				local first_part = {
					last_content_range[1],
					last_content_range[2],
					child_range[1],
					child_range[2],
				}
				local second_part = {
					child_range[3],
					child_range[4],
					last_content_range[3],
					last_content_range[4],
				}
				if is_range_empty_or_invalid(first_part) then
					if not is_range_empty_or_invalid(second_part) then
						content[#content] = second_part
					end
				elseif is_range_empty_or_invalid(second_part) then
					content[#content] = first_part
				else
					content[#content] = first_part
					content[#content + 1] = second_part
				end
			end
		end

		return content
	end

	local directives = vim.treesitter.query.list_directives()
	if not vim.tbl_contains(directives, "inject_without_children!") then
		vim.treesitter.query.add_directive(
			"inject_without_children!",
			function(match, _, _, predicate, metadata)
				local node = match[predicate[2]]
				metadata.content = make_subranges_between_children_like(
					node,
					function(_)
						return true
					end
				)
			end
		)
	end
end
