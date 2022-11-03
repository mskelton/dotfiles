-- Wrappers around some common CLI commands
vim.api.nvim_create_user_command("Pomo", "silent !pomo <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Task", "!task <args>", { nargs = "*" })

-- Create new file in current directory
-- TODO

-- Format/unformat files with JQ
vim.api.nvim_create_user_command("FormatJson", ":%!jq .", {})
vim.api.nvim_create_user_command("UnformatJson", ":%!jq -c .", {})
