return function()
	local ls = require("luasnip")

	ls.config.set_config({
		-- Update on each keypress
		update_events = "TextChanged,TextChangedI",
	})

	-- Filetype mappings
	ls.filetype_extend("typescriptreact", { "typescript", "javascriptreact" })
	ls.filetype_extend("typescript", { "javascript" })
	ls.filetype_extend("javascriptreact", { "javascript" })

	-- Load snippets
	require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

	-- Keymaps
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end, { silent = true })

	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end, { silent = true })

	vim.keymap.set("i", "<c-l>", function()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end, { silent = true })
end
