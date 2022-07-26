return function()
	vim.g.tokyonight_style = "storm"

	-- Dashboard header colors
	vim.highlight.create("StartLogo1", { guifg = "#1C506B" }, false)
	vim.highlight.create("StartLogo2", { guifg = "#1D5D68" }, false)
	vim.highlight.create("StartLogo3", { guifg = "#1E6965" }, false)
	vim.highlight.create("StartLogo4", { guifg = "#1F7562" }, false)
	vim.highlight.create("StartLogo5", { guifg = "#21825F" }, false)
	vim.highlight.create("StartLogo6", { guifg = "#228E5C" }, false)
	vim.highlight.create("StartLogo7", { guifg = "#239B59" }, false)
	vim.highlight.create("StartLogo8", { guifg = "#24A755" }, false)

	vim.cmd("colorscheme tokyonight")
end
