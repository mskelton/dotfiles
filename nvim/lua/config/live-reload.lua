return function()
	require("live-reload").setup({
		root_dir = "~/dev",
		plugins = {
			{ "bandit", dir = "bandit.nvim" },
			{ "live-reload", dir = "live-reload.nvim" },
		},
	})
end
