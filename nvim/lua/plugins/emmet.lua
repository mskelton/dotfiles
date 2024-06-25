return {
	"olrtg/nvim-emmet",
	config = function() end,
	keys = {
		{
			"<leader>em",
			function()
				require("nvim-emmet").wrap_with_abbreviation()
			end,
			mode = { "n", "v" },
			desc = "Wrap with abbreviation",
		},
	},
}
