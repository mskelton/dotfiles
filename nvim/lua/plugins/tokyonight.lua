return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			on_highlights = function(hl, c)
				hl["@constructor"] = { fg = c.red }
				hl["@tag"] = { fg = c.red }
				hl["@tag.attribute"] = { fg = c.purple }
				hl["@type.builtin"] = { fg = c.blue1 }

				-- Blue bold for functions
				hl["@function.call"] = { fg = c.blue, bold = true }
				hl["@function.macro"] = { fg = c.blue, bold = true }
				hl["@method.call"] = { fg = c.blue, bold = true }

				-- Italic purple for keyword type things
				hl["@keyword.function"] = { fg = c.purple, italic = true }
				hl["@keyword.return"] = { fg = c.purple, italic = true }
				hl.Statement = { fg = c.purple, italic = true }
				hl.PreProc = { fg = c.purple, italic = true }

				-- Make line numbers easier to read
				hl.LineNr = { fg = c.blue }
				hl.CursorLineNr = { fg = c.yellow }

				-- Improve readability of the window separators
				hl.WinSeparator = { bg = "none", fg = c.comment }

				-- De-emphasize text completions
				hl.CmpItemKindText = { fg = c.fg_dark }
			end,
		})

		vim.cmd("colorscheme tokyonight")
	end,
}
