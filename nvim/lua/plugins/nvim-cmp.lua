return {
	-- "hrsh7th/nvim-cmp",
	"yioneko/nvim-cmp",
	event = { "InsertEnter", "CmdLineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			config = function()
				local ls = require("luasnip")
				local map = require("core.utils").map

				ls.config.set_config({
					update_events = "TextChanged,TextChangedI",
					delete_check_events = "TextChanged,InsertLeave",
				})

				-- Filetype mappings
				ls.filetype_extend(
					"typescriptreact",
					{ "typescript", "javascriptreact", "javascript" }
				)
				ls.filetype_extend("typescript", { "javascript" })
				ls.filetype_extend("javascriptreact", { "javascript" })

				-- Load snippets
				require("luasnip.loaders.from_lua").lazy_load({
					paths = "~/.config/nvim/snippets",
				})

				-- Keymaps
				map({ "i", "s" }, "<c-n>", function()
					if ls.jumpable(1) then
						ls.jump(1)
					end
				end, "Next snippet jump point")

				map({ "i", "s" }, "<c-p>", function()
					if ls.jumpable(-1) then
						ls.jump(-1)
					end
				end, "Previous snippet jump point")
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
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
			mapping = {
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-j>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end,
				["<C-k>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,
				["<C-l>"] = function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true })
					elseif luasnip.expandable() then
						luasnip.expand({})
					elseif luasnip.choice_active() then
						luasnip.change_choice(1)
					else
						fallback()
					end
				end,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
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
					local strings = vim.split(kind.kind, "%s", { trimempty = true })

					kind.kind = strings[1] .. " "
					kind.menu = "   " .. strings[2]

					-- Highlight the menu text the same as the kind icon
					kind.menu_hl_group = "CmpItemKind" .. original_kind

					return kind
				end,
			},
		})

		local cmdline_next = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		}

		local cmdline_prev = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		}

		local cmdline_mapping = {
			["<C-e>"] = cmp.mapping.abort(),
			["<Tab>"] = cmdline_next,
			["<S-Tab>"] = cmdline_prev,
			["<C-j>"] = cmdline_next,
			["<C-k>"] = cmdline_prev,
		}

		local no_format = {
			fields = { "abbr" },
		}

		-- Use buffer source for '/'
		cmp.setup.cmdline({ "/", "?" }, {
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
				{ name = "cmdline" },
			}),
		})
	end,
}
