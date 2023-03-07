local M = {}

M.default_capabilities = function()
	return require("cmp_nvim_lsp").default_capabilities()
end

M.server = function(server, config)
	config = config or {}

	-- Unless the server explicitly specifies capabilities, use the default
	-- capabilities from nvim-cmp. This ensures completions and snippets work
	-- properly.
	if config.capabilities == nil then
		config.capabilities = M.default_capabilities()
	end

	require("lspconfig")[server].setup(config)
end

M.setup_servers = function()
	local util = require("lspconfig.util")

	-- Simple servers
	M.server("bashls")
	M.server("lua_ls")
	M.server("marksman")
	M.server("pyright")
	M.server("prismals")
	M.server("sourcekit", { filetypes = { "swift" } })
	M.server("rust_analyzer")
	M.server("emmet_ls")
	M.server("svelte")
	M.server("graphql")

	-- clangd requires a custom offset encoding, so we have to patch the default
	-- capabilities to make that work.
	local clangd_capabilities = M.default_capabilities()
	clangd_capabilities.offsetEncoding = { "utf-16" }

	M.server("clangd", {
		capabilities = clangd_capabilities,
		cmd = { "clangd", "-header-insertion=never" },
		filetypes = {
			"c",
			"cpp",
			"objc",
			"objcpp",
			"cuda",
			"proto",
			"mql5",
		},
	})

	M.server("gopls", {
		settings = {
			gopls = {
				-- Go uses the `tools` convention to separate build-time dependencies from
				-- runtime dependencies. This is a common convention in the Go community, so
				-- I support it out of the box.
				buildFlags = { "-tags=tools" },
			},
		},
	})

	M.server("jsonls", {
		settings = {
			json = { schemas = require("lsp.json-schemas") },
		},
	})

	M.server("yamlls", {
		settings = {
			yaml = { schemas = require("lsp.yaml-schemas") },
		},
	})

	M.server("stylelint_lsp", {
		root_dir = util.root_pattern(".stylelintrc", ".stylelintrc.js"),
		settings = {
			stylelintplus = {
				autoFixOnFormat = true,
			},
		},
	})

	M.server("eslint", {
		cmd = {
			--  Because Neovim always uses the `file` scheme for LSP URIs, I have a
			--  customized version of the ESLint language server that will not fail
			--  if the file doesn't exist.
			require("utils.npm").global_bin("vscode-eslint-language-server"),
			"--stdio",
		},
	})

	-- Only enable Tailwind if the project has a Tailwind config file
	M.server("tailwindcss", {
		root_dir = util.root_pattern(
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts"
		),
	})

	-- Setup TypeScript separately through the plugin. Long term, I don't want to
	-- use this plugin as I don't like that it's setup so differently from my
	-- other servers, but for now it is what it is.
	local tsserver = require("lsp.tsserver")

	require("typescript").setup({
		server = {
			capabilities = M.default_capabilities(),
			init_options = {
				plugins = tsserver.get_plugins(),
				tsserver = tsserver.get_tsserver_options(),
			},
			on_init = tsserver.on_init,
			handlers = tsserver.handlers,
		},
	})
end

M.setup = function()
	require("lsp.handlers").register_handlers()
	require("lsp.autocmd")
	require("lsp.null-ls")
	require("neodev").setup({})
	M.setup_servers()
end

return M
