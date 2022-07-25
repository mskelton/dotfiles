vim.api.nvim_create_user_command("Gradle", "!./gradlew <args>", { nargs = "+" })

-- Yarn
vim.api.nvim_create_user_command("Yarn", "!yarn <args>", { nargs = "+" })
vim.api.nvim_create_user_command("Y", "!yarn <args>", { nargs = "+" })

-- GitHub
vim.api.nvim_create_user_command("Hub", "!gh <args>", { nargs = "+" })
