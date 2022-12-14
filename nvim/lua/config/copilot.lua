---@diagnostic disable: param-type-mismatch
return function()
	vim.defer_fn(function()
		require("copilot").setup()
	end, 100)
end
