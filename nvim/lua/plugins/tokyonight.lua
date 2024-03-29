return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			on_highlights = function(hl, c)
				hl["@constructor"] = { fg = c.red }
				hl["@tag"] = { fg = c.red }
				hl["@tag.attribute"] = { fg = c.magenta }

				-- The defaults of darkening default types is just distracting
				hl["@type.builtin"] = nil

				-- Blue bold for functions
				hl["@function"] = { fg = c.blue, bold = true }
				hl["@function.call"] = { fg = c.blue, bold = true }
				hl["@function.macro"] = { fg = c.blue, bold = true }
				hl["@method.call"] = { fg = c.blue, bold = true }

				-- Italic magenta for keyword type things
				hl["@keyword"] = { fg = c.magenta, italic = true }
				hl["@keyword.function"] = { fg = c.magenta, italic = true }
				hl["@keyword.return"] = { fg = c.magenta, italic = true }

				-- Reset some of the defaults
				hl["@tag.tsx"] = nil
				hl["@constructor.tsx"] = nil
				hl["@tag.delimiter.tsx"] = nil

				-- Make line numbers easier to read
				hl.LineNr = { fg = c.blue }
				hl.CursorLineNr = { fg = c.yellow }

				-- Improve readability of the window separators
				hl.WinSeparator = { bg = "none", fg = c.comment }

				-- De-emphasize text completions
				hl.CmpItemKindText = { fg = c.fg_dark }
				hl.CmpItemKindVariable = { fg = c.magenta, bg = c.none }

				-- The default prompt color is orange, which doesn't work for my theme
				-- since the prompt and results are connected.
				hl.TelescopePromptBorder = { fg = c.border_highlight, bg = c.bg_float }
				hl.TelescopePromptTitle = { fg = c.border_highlight, bg = c.bg_float }
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
