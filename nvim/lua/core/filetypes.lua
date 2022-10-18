vim.filetype.add({
	extension = {
		mdx = "markdown",
	},
	filename = {
		[".stylelintrc"] = "json",
		["tsconfig.json"] = "jsonc",
	},
	pattern = {
		["tsconfig.*.json"] = "jsonc",
	},
})
