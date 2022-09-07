return function()
	require("toggleterm").setup({
		autochdir = true,
		open_mapping = [[<c-\>]],
		shade_terminals = false,
		insert_mappings = true,
	})
end
