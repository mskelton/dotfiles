local M = {}

M.default_capabilities = function()
	return require("cmp_nvim_lsp").default_capabilities()
end

M.server = function(server, config)
	config = config or {}

	-- Update the LSP capabilities to support completions and snippets.
	if config.capabilities == nil then
		config.capabilities = M.default_capabilities()
	end

	require("lspconfig")[server].setup(config)
end

M.setup_servers = function()
	local util = require("lspconfig.util")
	local tsserver = require("lsp.tsserver")
	local npm = require("utils.npm")

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

	-- Go uses the `tools` convention to separate build-time dependencies from
	-- runtime dependencies. This is a common convention in the Go community, so
	-- I support it out of the box.
	M.server("gopls", {
		settings = {
			gopls = {
				buildFlags = { "-tags=tools" },
			},
		},
	})

	M.server("yamlls", {
		settings = {
			yaml = { schemas = require("lsp.yaml-schemas") },
		},
	})

	M.server("jsonls", {
		settings = {
			json = { schemas = require("lsp.json-schemas") },
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
			npm.global_bin("vscode-eslint-language-server"),
			"--stdio",
		},
		settings = {
			validate = "on",
			packageManager = "npm",
			problems = {
				shortenToSingleLine = false,
			},
			experimental = {
				useFlatConfig = false,
			},
			useESLintClass = false,
			codeActionOnSave = {
				enable = false,
				mode = "all",
			},
			format = true,
			quiet = false,
			onIgnoredFiles = "off",
			rulesCustomizations = {},
			run = "onType",
			nodePath = "",
			workingDirectory = { mode = "location" },
			codeAction = {
				disableRuleComment = {
					enable = true,
					location = "separateLine",
				},
				showDocumentation = {
					enable = true,
				},
			},
		},
	})

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
	-- Register custom LSP handlers
	require("lsp.handlers").register_handlers()

	-- Setup autocmds and null-ls
	require("lsp.autocmd")
	require("lsp.null-ls")

	-- Better completion for Neovim Lua
	require("neodev").setup({})

	-- Setup LSP servers
	M.setup_servers()
end

return M
