--- @diagnostic disable: assign-type-mismatch

return {
	"hrsh7th/nvim-cmp",
	commit = "5260e5e8ecadaf13e6b82cf867a909f54e15fd07",
	event = { "InsertEnter", "CmdLineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
	},
	config = function()
		local cmp = require("cmp")
		local context = require("cmp.config.context")

		cmp.setup({
			completion = {
				--- Remove `noselect` from the `completeopt` so that we can select the
				--- first item automatically.
				completeopt = "menu,menuone",
			},
			--- Ignore LSP preselect items as it causes snippets to be skipped.
			preselect = cmp.PreselectMode.None,
			enabled = function()
				--- Completion is always allowed in command mode
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				end

				--- Disable completion in prompt buffers (e.g. Telescope)
				if
						vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt"
				then
					return false
				end

				--- Disable completion in markdown files
				if
						vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "markdown"
				then
					return false
				end

				--- Disable completion when editing comments
				return not (
					context.in_treesitter_capture("comment")
					or context.in_syntax_group("Comment")
				)
			end,
			mapping = {
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-j>"] = function()
					if cmp.visible() then
						cmp.select_next_item()
					else
						cmp.complete()
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

						--- Only return Emmet results in styled-component template strings
						return client_name ~= "emmet_language_server"
								or entry.context.filetype == "css"
								or context.in_treesitter_capture("styled")
					end,
				},
			}, {
				{ name = "buffer" },
			}),
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					--- cmp.config.compare.scopes,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					--- cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
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

		--- Use buffer source for '/'
		cmp.setup.cmdline({ "/", "?" }, {
			--- Don't auto-select the first item in search mode since enter is used
			--- to execute the search and thus we can't distinguish between enter
			--- to execute the search and enter to select the first item.
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			mapping = cmdline_mapping,
			formatting = no_format,
			sources = {
				{ name = "buffer" },
			},
		})

		--- Use cmdline & path source for ':'
		cmp.setup.cmdline(":", {
			completion = {
				--- Don't auto-select the first item in command mode since enter is used
				--- to execute the command and thus we can't distinguish between enter
				--- to execute the command and enter to select the first item.
				completeopt = "menu,menuone,noselect",
			},
			mapping = cmdline_mapping,
			formatting = no_format,
			sources = cmp.config.sources({
				{ name = "cmdline" },
			}),
		})
	end,
}
