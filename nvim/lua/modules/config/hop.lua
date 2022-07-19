function map(key, cmd)
	vim.keymap.set("n", key, cmd, { silent = true })
end

return function()
	local hop = require("hop")
	hop.setup()

	map("<space>hl", "<cmd>HopLine<cr>")
	map("<space>hw", "<cmd>HopWord<cr>")
	map("<space>hc", "<cmd>HopChar1<cr>")
	map("<space>hC", "<cmd>HopChar2<cr>")
end
