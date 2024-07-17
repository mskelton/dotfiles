local M = {}

--- @class WrapperOpts
--- @field public lang string
--- @field public query string
--- @field public capture_name string
--- @field public before string
--- @field public after string
--- @field public indent boolean

--- Wraps a tree-sitter node under the cursor matching a given capture group
--- with text before and after the node.
--- @param opts WrapperOpts
M.wrap = function(opts)
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	local col = cursor[2]

	local node = vim.treesitter.get_node({
		bufnr = bufnr,
		pos = { row, col },
	})

	if not node then
		return
	end

	--- Create a dynamic query from the provided options
	local query = vim.treesitter.query.parse(opts.lang, opts.query)

	--- Check if the current node or any of its parents match the query
	while node do
		--- Get the captures for the current node we are checking
		for id in query:iter_captures(node, bufnr, 0, -1) do
			local name = query.captures[id]

			--- If the node matches the given capture group name, wrap it
			if name == opts.capture_name then
				local start_row, start_col, end_row = node:range()
				local original_lines =
					vim.api.nvim_buf_get_lines(bufnr, start_row, end_row + 1, true)

				--- Determine the indent based on the user settings
				local indent = vim.bo.expandtab and string.rep(" ", vim.bo.shiftwidth)
					or "\t"

				--- Determine the indent of the node. This is used to ensure the
				--- before/after text is inserted with the same indent.
				local node_indent =
					string.rep(vim.bo.expandtab and " " or "\t", start_col)

				--- Create a new set of lines starting with the before text
				local lines = { node_indent .. opts.before }

				--- Indent the original lines
				for _, line in ipairs(original_lines) do
					table.insert(lines, indent .. line)
				end

				--- Add the after text after indenting the original lines
				table.insert(lines, node_indent .. opts.after)

				--- Update the text in the file
				vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, true, lines)

				return
			end
		end

		--- Didn't find any captures, continue up the tree
		node = node:parent()
	end
end

return M
