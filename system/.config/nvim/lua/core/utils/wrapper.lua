local M = {}

--- Add lines to the given table with the provided indent
--- @param lines string[]
--- @param text string|string[]
--- @param node_indent string
local function add_lines(lines, text, node_indent)
	if type(text) == "string" then
		table.insert(lines, node_indent .. text)
	else
		for _, line in ipairs(text) do
			local indent = line == "" and "" or node_indent
			table.insert(lines, indent .. line)
		end
	end
end

--- @class WrapperOpts
--- @field public lang string
--- @field public query string
--- @field public capture_name string
--- @field public before string|string[]
--- @field public after string|string[]
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
				local lines = {}

				--- Determine the indent of the node. This is used to ensure the
				--- before/after text is inserted with the same indent.
				local node_indent =
					string.rep(vim.bo.expandtab and " " or "\t", start_col)

				--- Add the before text before indenting the original lines
				add_lines(lines, opts.before, node_indent)

				--- Indent the original lines
				for _, line in ipairs(original_lines) do
					table.insert(lines, M.indent(line))
				end

				--- Add the after text
				add_lines(lines, opts.after, node_indent)

				--- Update the text in the file
				vim.api.nvim_buf_set_lines(bufnr, start_row, end_row + 1, true, lines)

				return
			end
		end

		--- Didn't find any captures, continue up the tree
		node = node:parent()
	end
end

--- Indent the given text based on the user settings
--- @param text string
M.indent = function(text)
	local indent = vim.bo.expandtab and string.rep(" ", vim.bo.shiftwidth) or "\t"

	return indent .. text
end

return M
