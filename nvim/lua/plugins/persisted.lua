return {
	"olimorris/persisted.nvim",
	event = "BufReadPre",
	keys = {
		{
			"<leader>so",
			function()
				require("persisted").load()
			end,
			mode = { "n", "v" },
			desc = "Load session for current directory",
		},
		{
			"<leader>sl",
			function()
				require("persisted").load({ last = true })
			end,
			mode = { "n", "v" },
			desc = "Load last session",
		},
		{
			"<leader>sq",
			mode = { "n", "v" },
			function()
				require("persisted").stop()
			end,
			desc = "Stop session",
		},
	},
	config = true,
}