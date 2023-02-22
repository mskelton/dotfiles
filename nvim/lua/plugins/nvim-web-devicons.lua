return {
	"mskelton/nvim-web-devicons",
	dependencies = { "mskelton/termicons.nvim" },
	config = function()
		local termicons = require("termicons")

		require("nvim-web-devicons").setup({
			override = termicons.get_overrides(),
			override_by_extension = termicons.get_overrides_by_extension(),
			override_by_filename = termicons.get_overrides_by_filename(),
		})
	end,
}
