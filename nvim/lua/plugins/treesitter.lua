require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash", "css", "dockerfile", "fish", "go", "gomod", "gowork", "graphql",
    "html", "javascript", "jsdoc", "json", "lua", "markdown", "python", "regex",
    "tsx", "typescript", "vim", "yaml"
  },
  sync_install = false,
  highlight = {
    enable = true,
  }
}
