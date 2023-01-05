-- Wrappers around some common CLI commands
vim.api.nvim_create_user_command("Pomo", "silent !pomo <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Task", "!task <args>", { nargs = "*" })

-- Create new file in current directory
vim.api.nvim_create_user_command("E", "e %:h/<args>", {
	nargs = 1,
	complete = function(_, _, _)
		return { "1", "2", "3" }
	end,
})

-- Format/unformat files with JQ
vim.api.nvim_create_user_command("FormatJson", ":%!jq .", {})
vim.api.nvim_create_user_command("UnformatJson", ":%!jq -c .", {})

-- Create an ISC license in a project
vim.api.nvim_create_user_command("CreateLicense", "!gh license isc", {})
