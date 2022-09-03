return function()
	local config = require("tokyonight.config")
	local c = require("tokyonight.colors").setup(config)

	vim.g.tokyonight_style = "storm"

	vim.cmd("colorscheme tokyonight")

	-- Tokyonight customizations
	vim.api.nvim_set_hl(0, "Function", { fg = c.blue, bold = true })
	vim.api.nvim_set_hl(0, "TSKeywordFunction", { fg = c.purple, italic = true })
	vim.api.nvim_set_hl(0, "TSConstructor", { fg = c.red })
	vim.api.nvim_set_hl(0, "TSTag", { fg = c.red })
	vim.api.nvim_set_hl(0, "TSTagAttribute", { fg = c.purple })

	-- Dashboard header colors
	vim.api.nvim_set_hl(0, "StartLogo1", { fg = "#1C506B" })
	vim.api.nvim_set_hl(0, "StartLogo2", { fg = "#1D5D68" })
	vim.api.nvim_set_hl(0, "StartLogo3", { fg = "#1E6965" })
	vim.api.nvim_set_hl(0, "StartLogo4", { fg = "#1F7562" })
	vim.api.nvim_set_hl(0, "StartLogo5", { fg = "#21825F" })
	vim.api.nvim_set_hl(0, "StartLogo6", { fg = "#228E5C" })
	vim.api.nvim_set_hl(0, "StartLogo7", { fg = "#239B59" })
	vim.api.nvim_set_hl(0, "StartLogo8", { fg = "#24A755" })

	-- Make line numbers easier to read
	vim.api.nvim_set_hl(0, "LineNr", { fg = c.blue })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.yellow })
end
