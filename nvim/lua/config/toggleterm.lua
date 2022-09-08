return function()
	require("toggleterm").setup({
		autochdir = true,
		direction = "float",
		insert_mappings = true,
		open_mapping = [[<c-\>]],
		shade_terminals = false,
	})
end
