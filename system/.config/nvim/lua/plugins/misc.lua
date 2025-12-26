return {
	{
		"tpope/vim-eunuch",
		cmd = {
			"Cfind",
			"Chmod",
			"Clocate",
			"Copy",
			"Delete",
			"Duplicate",
			"Lfind",
			"Llocate",
			"Mkdir",
			"Move",
			"Remove",
			"Rename",
			"SudoEdit",
			"SudoWrite",
			"Wall",
		},
	},
	{
		"tpope/vim-unimpaired",
		event = "VeryLazy",
		init = function()
			vim.g.nremap = { ["[x"] = "", ["]x"] = "" }
		end,
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
}
