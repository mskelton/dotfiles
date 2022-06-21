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
			TSField = { fg = "$red" },
			TSProperty = { fg = "$red" },
			TSParameter = { fg = "$orange" },
			TSPunctBracket = { fg = "$fg" },
			TSInclude = { fmt = "italic" },
			TSMethod = { fmt = "bold" },
			TSOperator = { fg = "$cyan" },
			TSStringEscape = { fg = "$cyan" },
		},
	})

	onedark.load()
end
