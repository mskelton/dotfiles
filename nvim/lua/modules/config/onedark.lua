return function()
	local onedark = require("onedark")

	onedark.setup({
		code_style = {
			comments = "italic",
			keywords = "italic",
			functions = "bold",
			strings = "none",
			variables = "none",
		},
	})

	onedark.load()
end
