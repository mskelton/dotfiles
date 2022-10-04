-- This table contains a list of file patterns and their associated default
-- json schema URLs. This listed was inspired by:
-- https://github.com/microsoft/vscode/blob/main/extensions/typescript-language-features/package.json#L77
return {
	{
		fileMatch = { "package.json" },
		url = "https://json.schemastore.org/package.json",
	},
	{
		fileMatch = {
			"tsconfig.json",
			"tsconfig.*.json",
			"tsconfig-*.json",
		},
		url = "https://json.schemastore.org/tsconfig",
	},
	{
		fileMatch = {
			".babelrc",
			".babelrc.json",
			"babelrc.config.json",
		},
		url = "https://json.schemastore.org/babelrc",
	},
	{
		fileMatch = {
			".prettierrc",
			".prettierrc.json",
			".prettierrc.json5",
		},
		url = "https://json.schemastore.org/prettierrc",
	},
	{
		fileMatch = {
			".eslintrc",
			".eslintrc.json",
		},
		url = "https://json.schemastore.org/eslintrc",
	},
	{
		fileMatch = {
			".stylelintrc",
			".stylelintrc.json",
		},
		url = "https://json.schemastore.org/stylelintrc",
	},
}
