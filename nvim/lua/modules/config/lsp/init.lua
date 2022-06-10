return function()
  local lspconfig = safe_require('lspconfig')
  if not lspconfig then
    return
  end

  require('modules.config.lsp.handlers').setup()
  require('modules.config.lsp.handlers').enable_format_on_save()
  require('modules.config.lsp.null-ls').setup()

  local servers_config = {
    emmet_ls = {
      cmd = { 'ls_emmet', '--stdio' },
      filetypes = { 'html', 'css', 'javascript', 'javascriptreact', 'typescriptreact' },
    },
  }

  local lsp_installer = safe_require('nvim-lsp-installer')
  if not lsp_installer then
    return
  end

  local servers = { 'emmet_ls', 'eslint', 'gopls', 'tsserver' }

  for _, name in pairs(servers) do
    local server_is_found, server = lsp_installer.get_server(name)

    if server_is_found and not server:is_installed() then
      server:install()
    end
  end

  lsp_installer.on_server_ready(function(server)
    local config = servers_config[server.name] or {}
    config.capabilities = require('modules.config.lsp.handlers').capabilities
    config.on_attach = require('modules.config.lsp.handlers').on_attach
    server:setup(config)
  end)
end
