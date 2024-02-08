vim.filetype.add({
	extension = {
		mdx = "markdown",
		mq5 = "mql5",
		mqh = "mql5",
		keymap = "dts",
		http = "http",
	},
	filename = {
		[".clangd"] = "yaml",
		[".clang-format"] = "yaml",
		[".releaserc"] = "json",
		[".swcrc"] = "json",
		["tsconfig.json"] = "jsonc",
	},
	pattern = {
		["tsconfig.*.json"] = "jsonc",
	},
})
