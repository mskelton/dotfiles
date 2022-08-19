return function()
	local ls = require("luasnip")
	local map = require("core.utils").map

	ls.config.set_config({
		history = true,
		update_events = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
	})

	-- Filetype mappings
	ls.filetype_extend("typescriptreact", { "typescript", "javascriptreact", "javascript" })
	ls.filetype_extend("typescript", { "javascript" })
	ls.filetype_extend("javascriptreact", { "javascript" })

	-- Load snippets
	require("luasnip.loaders.from_lua").lazy_load({
		paths = "~/.config/nvim/snippets",
	})

	-- Keymaps
	map({ "i", "s" }, "<c-j>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end)

	map({ "i", "s" }, "<c-k>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end)

	map("i", "<c-l>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end)
end
