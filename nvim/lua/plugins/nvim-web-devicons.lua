local eslint = {
	icon = "큤",
	color = "#8080F2",
	cterm_color = "60",
	name = "Eslint",
}

local javascript = {
	icon = "킠",
	color = "#cbcb41",
	cterm_color = "185",
	name = "Js",
}

local typescript = {
	icon = "텚",
	color = "#519aba",
	cterm_color = "67",
	name = "Ts",
}

local babel = {
	icon = "퀛",
	color = "#f9dc3e",
	cterm_color = "179",
	name = "Babel",
}

local tailwind = {
	icon = "텄",
	color = "#38bdf8",
	cterm_color = "75",
	name = "Tailwind",
}

local makefile = {
	icon = "킻",
	color = "#767676",
	cterm_color = "243",
	name = "Makefile",
}

local bash = {
	icon = "",
	color = "#767676",
	cterm_color = "243",
	name = "Bash",
}

local yarn = {
	icon = "텽",
	color = "#2188b6",
	cterm_color = "9",
	name = "Yarn",
}

local javascript_test = {
	icon = "텊",
	color = "#cbcb41",
	cterm_color = "185",
	name = "JavaScriptTest",
}

local typescript_test = {
	icon = "텊",
	color = "#519aba",
	cterm_color = "67",
	name = "TypeScriptTest",
}

local prettier = {
	icon = "탴",
	color = "#c596c7",
	cterm_color = "135",
	name = "Prettier",
}

return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override = {
			-- JS testing
			["spec.js"] = javascript_test,
			["spec.jsx"] = javascript_test,
			["spec.mjs"] = javascript_test,
			["spec.cjs"] = javascript_test,
			["test.js"] = javascript_test,
			["test.jsx"] = javascript_test,
			["test.mjs"] = javascript_test,
			["test.cjs"] = javascript_test,
			-- TS testing
			["spec.ts"] = typescript_test,
			["spec.tsx"] = typescript_test,
			["spec.mts"] = typescript_test,
			["spec.cts"] = typescript_test,
			["test.ts"] = typescript_test,
			["test.tsx"] = typescript_test,
			["test.mts"] = typescript_test,
			["test.cts"] = typescript_test,
		},
		override_by_extension = {
			-- CJS/ESM
			["cjs"] = javascript,
			["mjs"] = javascript,
			["cts"] = typescript,
			["mts"] = typescript,
		},
		override_by_filename = {
			-- Babel
			[".babelrc"] = babel,
			["babel.config.js"] = babel,
			["babel.config.cjs"] = babel,
			["babel.config.mjs"] = babel,
			-- ESLint
			[".eslintrc"] = eslint,
			[".eslintignore"] = eslint,
			["eslint.config.js"] = eslint,
			["eslint.config.cjs"] = eslint,
			["eslint.config.mjs"] = eslint,
			-- Prettier
			[".prettierrc"] = prettier,
			[".prettierignore"] = prettier,
			["prettier.config.js"] = prettier,
			["prettier.config.cjs"] = prettier,
			["prettier.config.mjs"] = prettier,
			-- Tailwind
			["tailwind.config.js"] = tailwind,
			["tailwind.config.cjs"] = tailwind,
			["tailwind.config.mjs"] = tailwind,
			-- Yarn
			["yarn.lock"] = yarn,
			[".yarnrc.yml"] = yarn,
			-- Misc
			["Makefile"] = makefile,
			["bats"] = bash,
		},
	},
}
