return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cmd = { "Neogit" },
	config = {
		signs = {
			hunk = { "", "" },
			item = { "", "" },
			section = { "", "" },
		},
	},
}
