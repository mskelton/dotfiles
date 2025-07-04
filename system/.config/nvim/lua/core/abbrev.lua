--- @vs-reviewed
vim.cmd.inoreabbrev("MS", "Mark Skelton")
vim.cmd.inoreabbrev("RN", "ReactNode")
vim.cmd.inoreabbrev("Null", "null")
vim.cmd.inoreabbrev("kn", "unknown")
vim.cmd.inoreabbrev("ud", "undefined")

vim.cmd("ca <expr> %% expand('%:p:h')")
