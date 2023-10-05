local M = {}

M.default_capabilities = function()
	return require("cmp_nvim_lsp").default_capabilities()
end

--- Make capabilities for a server. This is a helper function that allows you to
--- easily add custom capabilities to a server's capabilities.
--- @param fn function
--- @return table
M.make_capabilities = function(fn)
	local capabilities = M.default_capabilities()
	return fn(capabilities)
end

--- Setup a language server
--- @param server string
--- @param config table?
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
	M.server("vimls")
	M.server("bashls")
	M.server("pyright")
	M.server("prismals")
	M.server("rust_analyzer")
	M.server("sourcekit")
	M.server("emmet_ls")

	-- GraphQL
	M.server("graphql", {
		filetypes = { "graphql" },
		root_dir = util.root_pattern(
			".graphqlrc*",
			".graphql.config.*",
			"graphql.config.*"
		),
	})

	M.server("clangd", {
		-- clangd requires a custom offset encoding, so we have to patch the default
		-- capabilities to make that work.
		capabilities = M.make_capabilities(function(capabilities)
			capabilities.offsetEncoding = { "utf-16" }
			return capabilities
		end),
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

	-- Lua
	M.server("lua_ls", {
		settings = {
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	-- Go
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

	-- OCaml
	M.server("ocamllsp", {
		root_dir = util.root_pattern("*.opam", "dune-project", "dune-workspace"),
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

	M.server("eslint")
	M.server("cssls")

	-- Only enable Tailwind if the project has a Tailwind config file
	M.server("tailwindcss", {
		root_dir = util.root_pattern(
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts"
		),
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						-- Custom class name attributes (e.g. buttonClassName)
						{ [==[[a-zA-Z]*ClassName=["'`]([^"'`]+)["'`]]==] },
						-- cls, clsx
						-- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
						{ [[clsx?\(([^)]*)\)]], [["([^"]*)"]] },
						-- Tailwind Variants
						-- https://www.tailwind-variants.org/docs/getting-started#intellisense-setup-optional
						{ [[tv\(([^)]*)\)]], [==[["'`]([^"'`]*).*?["'`]]==] },
						-- `styles` objects
						-- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
						{ [[styles =([^}]*)\}]], [==[["'`]([^"'`]*).*?["'`]]==] },
					},
				},
			},
		},
	})
end

M.setup = function()
	-- Set the log level for the LSP client if an environment variable was provided
	local log_level = os.getenv("LOG_LEVEL")
	if log_level ~= nil then
		vim.lsp.set_log_level(log_level)
	end

	require("lsp.handlers").register_handlers()
	require("lsp.autocmd")
	require("lsp.null-ls")
	require("neodev").setup({})

	M.setup_servers()
end

return M
