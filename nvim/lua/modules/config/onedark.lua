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
			-- Dashboard header colors
			StartLogo1 = { fg = "#1C506B" },
			StartLogo2 = { fg = "#1D5D68" },
			StartLogo3 = { fg = "#1E6965" },
			StartLogo4 = { fg = "#1F7562" },
			StartLogo5 = { fg = "#21825F" },
			StartLogo6 = { fg = "#228E5C" },
			StartLogo7 = { fg = "#239B59" },
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
