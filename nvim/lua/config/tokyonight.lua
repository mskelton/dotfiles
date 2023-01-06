return function()
	require("tokyonight").setup({
		on_highlights = function(hl, c)
			hl["@function.call"] = { fg = c.blue, bold = true }
			hl["@method.call"] = { fg = c.blue, bold = true }
			hl["@keyword.return"] = { fg = c.purple, italic = true }
			hl["@constructor"] = { fg = c.red }
			hl["@tag"] = { fg = c.red }
			hl["@tag.attribute"] = { fg = c.purple }

			-- Improve CSS and styled-components highlighting
			hl["@unit"] = { fg = c.orange }

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
