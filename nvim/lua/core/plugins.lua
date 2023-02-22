vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

local lazy = require("lazy")

lazy.setup("plugins", {
	defaults = { lazy = true },
	change_detection = {
		enabled = false,
		notify = false,
	},
	dev = {
		path = "~/dev",
		patterns = { "mskelton" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

vim.keymap.set("n", "<leader>op", lazy.home, {
	silent = true,
	desc = "Open lazy.nvim",
})
