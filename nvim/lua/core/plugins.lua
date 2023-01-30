vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup("plugins", {
	-- defaults = { lazy = true },
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
