return function()
	local cmp = require("cmp")
	local context = require("cmp.config.context")
	local lspkind = require("lspkind")

	cmp.setup({
		enabled = function()
			-- Completion is always allowed in command mode
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			end

			-- Disable completion in prompt buffers (e.g. Telescope)
			if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
				return false
			end

			-- Disable completion when editing comments
			return not (
					context.in_treesitter_capture("comment")
					or context.in_syntax_group("Comment")
				)
		end,
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		experimental = {
			ghost_text = true,
		},
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(4),
			["<C-u>"] = cmp.mapping.scroll_docs(-4),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
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
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
		}),
		formatting = {
			format = lspkind.cmp_format({
				with_text = true,
				menu = {
					buffer = "[buf]",
					nvim_lsp = "[LSP]",
					path = "[path]",
					luasnip = "[snip]",
				},
			}),
		},
	})

	local cmdline_mapping = {
		["<Tab>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		["<S-Tab>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
		["<C-e>"] = {
			c = cmp.mapping.close(),
		},
	}

	-- Use buffer source for '/'
	cmp.setup.cmdline("/", {
		mapping = cmdline_mapping,
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'
	cmp.setup.cmdline(":", {
		mapping = cmdline_mapping,
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
