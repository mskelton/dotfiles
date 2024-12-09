vim.filetype.add({
	extension = {
		mdx = "markdown",
		mq5 = "mql5",
		mqh = "mql5",
		keymap = "dts",
		http = "http",
		har = "json",
		grit = "gritql",
	},
	filename = {
		[".clangd"] = "yaml",
		[".clang-format"] = "yaml",
		[".releaserc"] = "json",
		[".swcrc"] = "json",
		["tsconfig.json"] = "jsonc",
	},
	pattern = {
		[".env.*"] = "sh",
		["tsconfig.*.json"] = "jsonc",
	},
})
