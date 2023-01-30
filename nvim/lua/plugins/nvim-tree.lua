return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
			opts = {
				override = {
					[".eslintrc"] = {
						icon = "󰱺",
						color = "#4b32c3",
						cterm_color = "60",
						name = "Eslint",
					},
				},
			},
		},
	},
	keys = {
		{
			"<leader>fd",
			"<cmd>NvimTreeFindFileToggle!<cr>",
			mode = { "n", "v" },
		},
	},
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = true,
}
