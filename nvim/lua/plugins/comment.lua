return {
	"numToStr/Comment.nvim",
	event = "BufReadPost",
	dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
	init = function()
		vim.g.skip_ts_context_commentstring_module = true
	end,
	config = function()
		local js_comments = {
			__default = "// %s",
			jsx_element = "{/* %s */}",
			jsx_fragment = "{/* %s */}",
			jsx_attribute = "// %s",
			comment = "// %s",
		}

		require("ts_context_commentstring").setup({
			enable_autocmd = false,
			languages = {
				javascript = js_comments,
				typescript = js_comments,
				tsx = js_comments,
				lua = { __default = "--- %s" },
				scm = { __default = "; %s" },
			},
		})

		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
