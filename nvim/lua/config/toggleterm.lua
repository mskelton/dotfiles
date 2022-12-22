return function()
	require("toggleterm").setup({
		autochdir = true,
		direction = "float",
		insert_mappings = true,
		open_mapping = "<C-\\>",
		shade_terminals = false,
		float_opts = {
			border = "rounded",
		},
	})
end
