return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	keys = {
		{
			"<leader>so",
			function()
				require("persistence").load()
			end,
			mode = { "n", "v" },
			desc = "Load session for current directory",
		},
		{
			"<leader>sl",
			function()
				require("persistence").load({ last = true })
			end,
			mode = { "n", "v" },
			desc = "Load last session",
		},
		{
			"<leader>sq",
			mode = { "n", "v" },
			function()
				require("persistence").stop()
			end,
			desc = "Stop session",
		},
	},
	config = true,
}
