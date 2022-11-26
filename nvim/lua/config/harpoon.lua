return function()
	local map = require("core.utils").map
	local ui = require("harpoon.ui")

	map("n", "<leader>ho", function()
		ui.toggle_quick_menu()
	end)

	map("n", "<leader>ha", function()
		require("harpoon.mark").add_file()
	end)

	map("n", "[h", function()
		ui.nav_next()
	end)

	map("n", "]h", function()
		ui.nav_prev()
	end)
end
