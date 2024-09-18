local utils = require("core.utils")
local npm = require("utils.npm")

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

	if config.enabled == false then
		return
	end

	--- Unless the server explicitly specifies capabilities, use the default
	--- capabilities from nvim-cmp. This ensures completions and snippets work
	--- properly.
	if config.capabilities == nil then
		config.capabilities = M.default_capabilities()
	end

	require("lspconfig")[server].setup(config)
end

M.setup_servers = function()
	local util = require("lspconfig.util")

	--- Simple servers
	M.server("vimls")
	M.server("bashls")
	--- M.server("pyright")
	M.server("prismals")
	M.server("rust_analyzer")
	M.server("sourcekit")
	M.server("zls")
	M.server("taplo")

	--- GraphQL
	M.server("graphql", {
		filetypes = { "graphql" },
		root_dir = util.root_pattern(
			".graphqlrc*",
			".graphql.config.*",
			"graphql.config.*"
		),
	})

	M.server("clangd", {
		--- clangd requires a custom offset encoding, so we have to patch the default
		--- capabilities to make that work.
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

	--- Lua
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

	--- Go
	M.server("gopls", {
		settings = {
			gopls = {
				--- Go uses the `tools` convention to separate build-time dependencies from
				--- runtime dependencies. This is a common convention in the Go community, so
				--- I support it out of the box.
				buildFlags = { "-tags=tools" },
			},
		},
	})

	--- OCaml
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

	M.server("biome")
	M.server("eslint", {
		on_attach = function(_, bufnr)
			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set("n", "<leader>el", function()
				vim.lsp.buf.code_action({
					apply = true,
					filter = function(action)
						return action.command.command == "eslint.applyDisableLine"
					end,
				})
			end, opts)

			vim.keymap.set("n", "<leader>ef", function()
				vim.lsp.buf.code_action({
					apply = true,
					filter = function(action)
						return action.command.command == "eslint.applyDisableFile"
					end,
				})
			end, opts)
		end,
	})
	M.server("cssls")
	M.server("svelte")

	M.server("emmet_language_server", {
		enabled = false,
		filetypes = {
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"typescriptreact",
		},
		init_options = {
			extensionsPath = {
				vim.fn.stdpath("config") .. "/emmet",
			},
			includeLanguages = {
				javascript = "css",
				javascriptreact = "css",
				typescriptreact = "css",
			},
		},
	})

	M.server("vtsls", {
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		settings = {
			typescript = {
				preferences = {
					autoImportFileExcludePatterns = {
						"**/.next/*",
						"**/postcss",
						"**/react-aria-components",
					},
				},
			},
			vtsls = {
				autoUseWorkspaceTsdk = true,
			},
		},
		on_attach = function(client, bufnr)
			local plugins = {
				{
					name = "typescript-styled-plugin",
					location = npm.mason_lib("typescript-styled-plugin"),
					config = {
						validate = false,
						emmet = { showExpandedAbbreviation = "never" },
					},
				},
			}

			for _, value in ipairs(plugins) do
				if value.enabled then
					local params = {
						command = "_typescript.configurePlugin",
						arguments = { value.name, value.config },
					}

					client.request("workspace/executeCommand", params)
				end
			end

			local ts_utils = require("lsp.typescript")
			local opts = { buffer = bufnr, silent = true }

			vim.keymap.set("n", "go", function()
				ts_utils.add_missing_imports(bufnr, client)
			end, opts)

			vim.keymap.set("n", "gO", function()
				ts_utils.remove_unused_imports(bufnr, client)
			end, opts)

			vim.keymap.set("n", "<leader>rf", function()
				ts_utils.rename_file(bufnr)
			end, opts)

			vim.keymap.set("n", "<leader>oab", function()
				ts_utils.add_braces_to_arrow_function(bufnr)
			end, opts)

			vim.keymap.set("n", "<leader>orb", function()
				ts_utils.remove_braces_from_arrow_function(bufnr)
			end, opts)

			vim.keymap.set("n", "<leader>onf", function()
				ts_utils.convert_to_named_function(bufnr)
			end, opts)
		end,
		handlers = {
			--- Filter out certain paths from the results that are 99% of the time
			--- false positive results for my use case. If I explicitly jump to
			--- them, go there, otherwise ignore them.
			["textDocument/definition"] = function(_, result, ...)
				if vim.islist(result) then
					local ignored_paths = {
						"react/index.d.ts",
						"react/ts5.0/index.d.ts",
						"tailwind-variants/dist/index.d.ts",
						"styled-components/dist/types.d.ts",
					}

					for key, value in ipairs(result) do
						for _, ignored_path in pairs(ignored_paths) do
							--- If an ignored path is the first result, keep it as it's
							--- likely the intended path.
							if
								key ~= 1 and utils.ends_with(value.targetUri, ignored_path)
							then
								table.remove(result, key)
							end
						end
					end
				end

				--- Defer to the built-in handler after filtering the results
				vim.lsp.handlers["textDocument/definition"](_, result, ...)
			end,
			--- Disable specific diagnostics that I don't care about. TypeScript has
			--- some super opinionated diagnostics that don't always make sense.
			["textDocument/publishDiagnostics"] = function(_, result, ...)
				local ignored_codes = {
					--- File is a CommonJS module; it may be converted to an ES module
					80001,
				}

				--- Filter out diagnostics that are ignored
				for key, value in ipairs(result.diagnostics) do
					for _, ignored_code in ipairs(ignored_codes) do
						if value.code == ignored_code then
							table.remove(result.diagnostics, key)
						end
					end
				end

				vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ...)
			end,
		},
	})

	--- Only enable Tailwind if the project has a Tailwind config file
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
						--- Custom class name attributes (e.g. buttonClassName)
						{ [==[[a-zA-Z]*ClassName=["'`]([^"'`]+)["'`]]==] },
						--- cls, clsx
						--- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
						{
							[[clsx\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
							'"(.*?)"',
						},
						--- Tailwind Variants
						--- https://www.tailwind-variants.org/docs/getting-started#intellisense-setup-optional
						{
							[[tv\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)]],
							'"(.*?)"',
						},
						--- `styles` objects
						--- https://github.com/tailwindlabs/tailwindcss-intellisense/issues/682#issuecomment-1364585313
						{ [[styles =([^}]*)\}]], [==[["'`]([^"'`]*).*?["'`]]==] },
					},
				},
			},
		},
	})
end

M.setup = function()
	--- Set the log level for the LSP client if an environment variable was provided
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
