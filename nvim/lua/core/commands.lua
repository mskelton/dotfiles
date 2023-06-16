-- Wrappers around some common CLI commands
vim.api.nvim_create_user_command("Pomo", "silent !pomo <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Task", "!task <args>", { nargs = "*" })

-- Format/unformat files with JQ
vim.api.nvim_create_user_command("JsonFormat", ":%!jq .", {})
vim.api.nvim_create_user_command("JsonUnformat", ":%!jq -c .", {})
vim.api.nvim_create_user_command(
	"JsonCopy",
	[[:silent %w !jq -c . | sed "s/\"/\\\\\"/g" | tr -d "\n" | pbcopy]],
	{}
)

-- Create an ISC license in a project
vim.api.nvim_create_user_command("CreateLicense", "!gh license isc", {})

-- Browse a URL in the default browser. Needed for vim-fugitive
vim.api.nvim_create_user_command(
	"Browse",
	"silent !open <args>",
	{ nargs = "*" }
)
