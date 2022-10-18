return function()
	local cmp = require("cmp")
	local context = require("cmp.config.context")
	local format = require("lspkind").cmp_format({
		mode = "symbol_text",
		maxwidth = 50,
		preset = "codicons",
	})

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

			-- Disable completion in markdown files
			if vim.api.nvim_buf_get_option(0, "filetype") == "markdown" then
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
			["<C-Space>"] = cmp.mapping.complete({}),
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
			{
				name = "nvim_lsp",
				entry_filter = function(entry)
					local client_name = entry.source.source.client.name

					-- Only return Emmet results in Emotion template strings
					return client_name ~= "emmet_ls"
						or context.in_treesitter_capture("emotion")
				end,
			},
			{ name = "luasnip" },
			{ name = "buffer" },
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				local original_kind = vim_item.kind
				local kind = format(entry, vim_item)

				-- Split the kind from lspkind into two parts so we can place the icon
				-- on the left and the text on the right. This allows for quick scanning
				-- on the left near the text while still providing the full completion
				-- information if needed.
				---@diagnostic disable-next-line: param-type-mismatch
				local strings = vim.split(kind.kind, "%s", { trimempty = true })

				kind.kind = strings[1] .. " "
				kind.menu = "   " .. strings[2]

				-- Highlight the menu text the same as the kind icon
				kind.menu_hl_group = "CmpItemKind" .. original_kind

				return kind
			end,
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

	local no_format = {
		fields = { "abbr" },
	}

	-- Use buffer source for '/'
	cmp.setup.cmdline("/", {
		mapping = cmdline_mapping,
		formatting = no_format,
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'
	cmp.setup.cmdline(":", {
		mapping = cmdline_mapping,
		formatting = no_format,
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
