local eslint = {
	icon = "",
	color = "#8080F2",
	cterm_color = "60",
	name = "Eslint",
}

local javascript = {
	icon = "",
	color = "#cbcb41",
	cterm_color = "185",
	name = "Js",
}

local typescript = {
	icon = "",
	color = "#519aba",
	cterm_color = "67",
	name = "Ts",
}

local babel = {
	icon = "",
	color = "#f9dc3e",
	cterm_color = "179",
	name = "Babel",
}

local tailwind = {
	icon = "󱏿",
	color = "#38bdf8",
	cterm_color = "75",
	name = "Tailwind",
}

local gnu = {
	icon = "",
	color = "#767676",
	cterm_color = "243",
	name = "GNU",
}

local bash = {
	icon = "",
	color = "#767676",
	cterm_color = "243",
	name = "Bash",
}

local yarn = {
	icon = "",
	color = "#2188b6",
	cterm_color = "9",
	name = "Yarn",
}

local test = {
	icon = "",
	color = "#f9dc3e",
	cterm_color = "11",
	name = "Test",
}

return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override = {
			-- JS testing
			["spec.js"] = test,
			["test.js"] = test,
			-- TS testing
			["spec.ts"] = test,
			["spec.mts"] = test,
			["spec.cts"] = test,
			["test.ts"] = test,
			["test.mts"] = test,
			["test.cts"] = test,
			["spec.tsx"] = test,
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
			-- Tailwind
			["tailwind.config.js"] = tailwind,
			["tailwind.config.cjs"] = tailwind,
			["tailwind.config.mjs"] = tailwind,
			-- Yarn
			["yarn.lock"] = yarn,
			[".yarnrc.yml"] = yarn,
			-- Misc
			["Makefile"] = gnu,
			["bats"] = bash,
		},
	},
}
