local map = require("core.utils").map

--- Entire text object
---------------------
map("v", "ae", ":<C-U>silent! normal! ggVG<cr>")
map("o", "ae", ":normal Vae<cr>", { remap = true })

--- Remap "sentence" text object to capital S
--- since I use lowercase s for statement
--------------------------------------------
map({ "v", "o" }, "aS", "as")
map({ "v", "o" }, "iS", "is")

--- Line text object
-------------------
map("v", "al", ":<C-U>silent! normal! 0v$<cr>")
map("o", "al", ":normal val<cr>", { remap = true })
map("v", "il", ":<C-U>silent! normal! ^vg_<cr>")
map("o", "il", ":normal vil<cr>", { remap = true })

--- Class name text object
-------------------------
map("v", "an", ":<C-U>silent! lua ClassName()<cr>")
map("o", "an", ":normal van<cr>", { remap = true })

function ClassName()
	local captures = vim.treesitter.get_captures_at_cursor(0)
	if not vim.tbl_contains(captures, "string") then
		return
	end

	local pattern = '[" ]'
	local found_separator = false
	local line = vim.fn.getline(".")

	local function get_char()
		local col = vim.fn.col(".")
		return string.sub(line, col, col)
	end

	--- Search to end
	vim.fn.search(pattern, "cW")
	if get_char() == " " then
		found_separator = true
		vim.cmd.normal("v")
	else
		vim.cmd.normal("hv")
	end

	--- Search to start
	vim.fn.search(pattern, "bW")
	if get_char() == " " and not found_separator then
		vim.cmd.normal("o")
	else
		vim.cmd.normal("lo")
	end
end
