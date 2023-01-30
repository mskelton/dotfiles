local eslint = {
	icon = "",
	color = "#8080F2",
	cterm_color = "60",
	name = "Eslint",
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

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			opts = {
				override = {
					[".eslintrc"] = eslint,
					["eslint.config.js"] = eslint,
					["eslint.config.cjs"] = eslint,
					["eslint.config.mjs"] = eslint,
					["cts"] = typescript,
					["mts"] = typescript,
					[".babelrc"] = babel,
					["babel.config.js"] = babel,
					["babel.config.cjs"] = babel,
					["babel.config.mjs"] = babel,
					["tailwind.config.js"] = tailwind,
					["tailwind.config.cjs"] = tailwind,
					["tailwind.config.mjs"] = tailwind,
				},
			},
		},
	},
	keys = {
		{
			"<leader>fd",
			"<cmd>NvimTreeFindFileToggle!<cr>",
			mode = { "n", "v" },
			desc = "Toggle file tree",
		},
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = true,
}
