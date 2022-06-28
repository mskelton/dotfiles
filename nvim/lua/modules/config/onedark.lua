return function()
	local onedark = require("onedark")

	onedark.setup({
		toggle_style_key = "<NOP>",
		code_style = {
			comments = "italic",
			keywords = "italic",
			functions = "bold",
			strings = "none",
			variables = "none",
		},
		highlights = {
			-- Alpha header colors
			AlphaColor1 = { fg = "$blue" },
			AlphaColor2 = { fg = "$cyan" },
			AlphaColor3 = { fg = "$green" },
			AlphaColor4 = { fg = "$orange" },
			AlphaColor5 = { fg = "$red" },
			AlphaColor6 = { fg = "$purple" },
			AlphaColor7 = { fg = "$yellow" },
			-- Default search is too much, tone it down a bit
			IncSearch = { fg = "$fg", bg = "$bg3" },
			Search = { fg = "$fg", bg = "$bg3" },
			-- Match up with VS Code styles a bit better
			TSField = { fg = "$red" },
			TSTitle = { fg = "$red" },
			TSInclude = { fmt = "italic" },
			TSMethod = { fmt = "bold" },
			TSOperator = { fg = "$cyan" },
			TSParameter = { fg = "$orange" },
			TSProperty = { fg = "$red" },
			TSStringEscape = { fg = "$cyan" },
			TSType = { fg = "$yellow" },
			TSTypeBuiltin = { fg = "$yellow" },
			TSVariableBuiltin = { fg = "$yellow" },
		},
	})

	onedark.load()
end
