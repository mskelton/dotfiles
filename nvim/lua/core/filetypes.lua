--- @vs-reviewed
vim.filetype.add({
	extension = {
		mdx = "markdown",
		mdc = "markdown",
		mq5 = "mql5",
		mqh = "mql5",
		keymap = "dts",
		http = "http",
		har = "json",
		grit = "gritql",
		["code-snippets"] = "jsonc",
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
		[".*/.vscode/.*.json"] = "jsonc",
	},
})
