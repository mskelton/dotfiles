return function()
  local treesitter = safe_require('nvim-treesitter.configs')
  if not treesitter then
    return
  end

  treesitter.setup {
    autotag = {
      enable = true,
    },
    ensure_installed = {
      "bash",
			"css",
			"dockerfile",
			"fish",
			"go",
			"gomod",
			"gowork",
			"graphql",
      "html",
			"java",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"markdown",
			"python",
			"regex",
      "tsx",
			"typescript",
			"vim",
			"yaml",
    },
    sync_install = false,
    highlight = {
      enable = true,
    },
  }
end
