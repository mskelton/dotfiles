function P(...)
	print(vim.inspect(...))
end

--- Navigate to the line and reposition at the center of the window if
--- possible. This could be simplified by simply calling `<C-d>zz` or `<C-u>zz`
--- but that results in an intermediate redraw which causes flashing that bugs
--- me. Additionally, it produces inconsistent jump length based on your cursor
--- location. This behaves like `<C-d>` and `<C-u>` in that it does not modify
--- the jump list.
function MoveHalf(sign)
	local line = vim.api.nvim_win_get_cursor(0)[1]
	local win_height = vim.api.nvim_win_get_height(0)

	--- The line to navigate to should be exactly half the window size away from
	--- the cursor line (rounded down to ensure we never jump more than half the
	--- window).
	line = line + math.floor(win_height / 2) * sign

	--- Because vim allows negative numbers when jumping, we need to set a minimum
	--- value otherwise navigating up near the top of the window will produce very
	--- strange reuslts.
	line = math.max(line, 1)

	--- Navigate the the line without modifying the jump list
	vim.cmd("keepjumps normal " .. line .. "zz")
end
