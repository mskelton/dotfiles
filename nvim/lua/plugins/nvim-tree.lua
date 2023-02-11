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
	config = function()
		local api = require("nvim-tree.api")
		local map = require("core.utils").map

		require("nvim-tree").setup({
			trash = {
				cmd = "trash",
			},
			ui = {
				confirm = {
					trash = false,
				},
			},
			remove_keymaps = { "<CR>", "d" },
			on_attach = function(bufnr)
				local opts = { buffer = bufnr }

				-- `dd` is much more familiar for deleting files. Also, I use the trash
				-- command, so it's pretty safe to use.
				map("n", "dd", api.fs.trash, opts)

				-- Auto close the tree after selecting a file. Use tab to preview.
				map("n", "<cr>", function()
					api.node.open.edit()
					api.tree.close()
				end, opts)
			end,
		})
	end,
}
