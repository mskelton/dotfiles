return function()
	local js_comments = {
		__default = "// %s",
		jsx_element = "{/* %s */}",
		jsx_fragment = "{/* %s */}",
		jsx_attribute = "// %s",
		comment = "// %s",
	}

	require("nvim-treesitter.configs").setup({
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
			config = {
				javascript = js_comments,
				typescript = js_comments,
				tsx = js_comments,
			},
		},
	})

	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	})
end
