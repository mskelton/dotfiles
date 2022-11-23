return function()
	local util = require("lspconfig.util")
	local tsserver = require("config.lsp.tsserver")

	-- Setup autocmds and null-ls
	require("config.lsp.autocmd")
	require("config.lsp.null-ls")

	-- Better completion for Neovim Lua
	require("neodev").setup({})

	-- Custom config per LSP. The order of keys in this table is very important
	-- when it comes to code actions. Code actions will be prioritized bottom
	-- to top in this table.
	local servers = {
		bashls = {},
		clangd = {},
		gopls = {
			settings = {
				gopls = {
					buildFlags = { "-tags=tools" },
				},
			},
		},
		sourcekit = {
			filetypes = { "swift" },
		},
		sumneko_lua = {},
		rust_analyzer = {},
		yamlls = {
			settings = {
				yaml = { schemas = require("config.lsp.yaml-schemas") },
			},
		},
		emmet_ls = {
			cmd = {
				tsserver.npm_global_bin("emmet-ls"),
				"--stdio",
			},
		},
		jsonls = {
			settings = {
				json = { schemas = require("config.lsp.json-schemas") },
			},
		},
		stylelint_lsp = {
			root_dir = util.root_pattern(".stylelintrc", ".stylelintrc.js"),
			settings = {
				stylelintplus = {
					autoFixOnFormat = true,
				},
			},
		},
		eslint = {
			cmd = {
				tsserver.npm_global_bin("vscode-eslint-language-server"),
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
				-- nodePath configures the directory in which the eslint server should start its node_modules resolution.
				-- This path is relative to the workspace folder (root dir) of the server instance.
				nodePath = "",
				-- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
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
		},
		tailwindcss = {
			root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.ts"),
		},
	}

	-- Install all servers
	require("mason").setup({ ui = { border = "rounded" } })
	require("mason-lspconfig").setup({
		automatic_installation = { exclude = { "emmet_ls" } },
	})
	require("mason-null-ls").setup({ automatic_installation = true })

	-- Update the LSP capabilities to support completions and snippets.
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Setup all LSP clients
	for server, config in pairs(servers) do
		config.capabilities = capabilities
		require("lspconfig")[server].setup(config)
	end

	-- Setup TypeScript separately through the plugin
	require("typescript").setup({
		server = {
			init_options = {
				plugins = tsserver.get_plugins(),
				-- NOTE: Uncomment to enable verbose logging
				-- tsserver = { logVerbosity = "verbose" },
			},
			on_init = tsserver.on_init,
			handlers = tsserver.handlers,
		},
	})
end
