vim.filetype.add({
	extension = {
		mdx = "markdown",
		mq5 = "cpp",
		mq4 = "cpp",
		mqh = "cpp",
	},
	filename = {
		[".stylelintrc"] = "json",
		[".clangd"] = "yaml",
		[".clang-format"] = "yaml",
		["tsconfig.json"] = "jsonc",
	},
	pattern = {
		["tsconfig.*.json"] = "jsonc",
	},
})
