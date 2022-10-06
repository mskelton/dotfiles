local utils = require("core.utils")

local M = {}

-- Custom handlers for LSP actions
M.handlers = {
	["textDocument/definition"] = function(_, result, ...)
		-- Filter out certain paths from the results that are 99% of the time
		-- false positive results for my use case. If I explicitly jump to
		-- them, go there, otherwise ignore them.
		if vim.tbl_islist(result) then
			local ignored_paths = {
				"react/index.d.ts",
				"patterns-core/src/types/polymorphic.ts",
			}

			for key, value in ipairs(result) do
				for _, path in pairs(ignored_paths) do
					-- If an ignored path is the first result, keep it as it's
					-- likely the intended path.
					if key ~= 1 and utils.ends_with(value.targetUri, path) then
						table.remove(result, key)
					end
				end
			end
		end

		-- Defer to the built-in handler after filtering the results
		vim.lsp.handlers["textDocument/definition"](_, result, ...)
	end,
}

return M
