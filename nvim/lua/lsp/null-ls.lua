local null_ls = require("null-ls")
local utils = require("null-ls.utils")
local helpers = require("null-ls.helpers")

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

local prettier_config_files = {
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
}

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettierd.with({
			condition = function(conditions)
				return conditions.root_has_file(prettier_config_files)
					or has_manifest_config(conditions, "prettier")
			end,
			cwd = helpers.cache.by_bufnr(function(params)
				--- Small hack to prevent unwanted formatting of files in node_modules.
				--- If a file is in node_modules, it will likely find a `package.json`
				--- file as an ancestor, and then use that as the cwd, which will cause
				--- `.prettierignore` files in the root of the project to not be
				--- respected. To fix this, we strip out the `node_modules` part of the
				--- path so that we always resolve the cwd to actual project files. This
				--- still might not be the root of the project in the case of a monorepo,
				--- but it prevents any directory in `node_modules` from being used as
				--- the cwd.
				local bufname = string.gsub(params.bufname, "node_modules/.*", "")

				return utils.root_pattern(prettier_config_files, "package.json")(
					bufname
				)
			end),
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
		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.formatting.mdformat.with({
			condition = function(util)
				return util.root_has_file({ ".mdformat.toml" })
			end,
		}),
	},
})
