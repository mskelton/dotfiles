--- @vs-reviewed
vim.filetype.add({
	extension = {
		mdx = "markdown",
		mdc = "markdown",
		keymap = "dts",
		http = "http",
		har = "json",
		["code-snippets"] = "jsonc",
	},
	filename = {
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
