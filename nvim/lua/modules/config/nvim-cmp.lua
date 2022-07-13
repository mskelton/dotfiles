return function()
	local cmp = require("cmp")
	local context = require("cmp.config.context")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	cmp.setup({
		-- Disable completion when editing comments
		enabled = function()
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end,
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		experimental = {
			ghost_text = true,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(4),
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<C-e>"] = cmp.mapping.abort(),
			-- Tab and S-Tab to navigate results. This is preferred over C-n and C-p
			-- to prevent command line completion from interferring with navigating
			-- the command history.
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
			["<S-Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
			-- Enter only completes if a completion was explicitly selected
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer", keyword_length = 4 },
		}),
		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[api]",
					path = "[path]",
					luasnip = "[snip]",
					tn = "[TabNine]",
				},
			}),
		},
	})

	-- Use buffer source for '/'
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
