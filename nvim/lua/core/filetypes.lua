vim.filetype.add({
	extension = {
		mdx = "markdown",
		mq5 = "mql5",
		mqh = "mql5",
		keymap = "dts",
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
