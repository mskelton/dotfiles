vim.filetype.add({
	extension = {
		mdx = "markdown",
		mq5 = "mql5",
		mqh = "mql5",
		keymap = "dts",
	},
	filename = {
		[".clangd"] = "yaml",
		[".clang-format"] = "yaml",
		[".releaserc"] = "json",
		["tsconfig.json"] = "jsonc",
	},
	pattern = {
		["tsconfig.*.json"] = "jsonc",
	},
})
