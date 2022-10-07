vim.api.nvim_create_user_command("Gradle", "!./gradlew <args>", { nargs = "+" })
vim.api.nvim_create_user_command("Hub", "!gh <args>", { nargs = "+" })
vim.api.nvim_create_user_command("Pomo", "silent !pomo <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Task", "!task <args>", { nargs = "*" })
vim.api.nvim_create_user_command("Yarn", "!yarn <args>", { nargs = "*" })

-- Create new file in current directory
