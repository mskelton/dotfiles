return function()
	require("tokyonight").setup({
		on_highlights = function(hl, c)
			hl.Function = { fg = c.blue, bold = true }
			hl.TSKeywordFunction = { fg = c.purple, italic = true }
			hl.TSConstructor = { fg = c.red }
			hl.TSTag = { fg = c.red }
			hl.TSTagAttribute = { fg = c.purple }

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
end
