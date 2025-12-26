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
		[".clang-format"] = "yaml",
		[".clangd"] = "yaml",
		[".dockerignore"] = "gitignore",
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
