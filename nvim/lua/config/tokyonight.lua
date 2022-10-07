return function()
	require("tokyonight").setup({
		on_highlights = function(hl, c)
			hl.Function = { fg = c.blue, bold = true }
			hl.TSKeywordFunction = { fg = c.purple, italic = true }
			hl.TSConstructor = { fg = c.red }
			hl.TSTag = { fg = c.red }
			hl.TSTagAttribute = { fg = c.purple }

			-- Dashboard header colors
			hl.StartLogo1 = { fg = "#1C506B" }
			hl.StartLogo2 = { fg = "#1D5D68" }
			hl.StartLogo3 = { fg = "#1E6965" }
			hl.StartLogo4 = { fg = "#1F7562" }
			hl.StartLogo5 = { fg = "#21825F" }
			hl.StartLogo6 = { fg = "#228E5C" }
			hl.StartLogo7 = { fg = "#239B59" }
			hl.StartLogo8 = { fg = "#24A755" }

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
