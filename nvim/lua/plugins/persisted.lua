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
			"<leader>sq",
			mode = { "n", "v" },
			function()
				require("persisted").stop()
			end,
			desc = "Stop session",
		},
	},
	init = function()
		vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,terminal"
	end,
	config = true,
}
