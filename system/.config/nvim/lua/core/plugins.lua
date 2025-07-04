vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup("plugins", {
	defaults = { lazy = true },
	change_detection = {
		enabled = false,
		notify = false,
	},
	dev = {
		path = "~/dev",
		patterns = { "mskelton" },
		fallback = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				--- "netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

vim.keymap.set("n", "<leader>op", require("lazy").home, {
	silent = true,
	desc = "Open lazy.nvim",
})
