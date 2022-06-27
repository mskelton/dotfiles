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
			IncSearch = { fg = "$fg", bg = "$bg3" },
			Search = { fg = "$fg", bg = "$bg3" },
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
