local null_ls = require("null-ls")
local utils = require("null-ls.utils")

--- Check if the project has a package manifest configuration
--- @param conditions table
--- @param key string
local function has_manifest_config(conditions, key)
	if conditions.root_has_file({ "package.json" }) then
		local filename = utils.get_root() .. "/package.json"
		local manifest = vim.json.decode(table.concat(vim.fn.readfile(filename)))

		--- Check if the manifest has the key
		return manifest ~= nil and manifest[key] ~= nil
	end

	return false
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd.with({
			condition = function(conditions)
				return conditions.root_has_file({
					".prettierrc",
					".prettierrc.cjs",
					".prettierrc.js",
					".prettierrc.json",
					".prettierrc.json5",
					".prettierrc.mjs",
					".prettierrc.toml",
					".prettierrc.yaml",
					".prettierrc.yml",
					"prettier.config.cjs",
					"prettier.config.js",
					"prettier.config.mjs",
				}) or has_manifest_config(conditions, "prettier")
			end,
			env = {
				PRETTIERD_LOCAL_PRETTIER_ONLY = true,
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"jsonc",
				"yaml",
				"markdown",
				"markdown.mdx",
				"graphql",
				"handlebars",
				"sql",
				"svg",
				"svelte",
			},
		}),
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.dtsfmt,
		null_ls.builtins.formatting.swiftformat,
		null_ls.builtins.formatting.mdformat.with({
			condition = function(util)
				return util.root_has_file({ ".mdformat.toml" })
			end,
		}),
	},
})
