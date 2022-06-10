local M = {}

M.setup = function()
end

-- Use an on_attach function to only map keybindings to LSP commands after the
-- language server attaches to the current buffer.
M.on_attach = function(client, bufnr)
  local function map(key, cmd)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, '<cmd>lua ' .. cmd .. '<CR>', opts)
  end

  map('K', 'vim.lsp.buf.hover()')
  map('gd', 'vim.lsp.buf.definition()')
  map('gD', 'vim.lsp.buf.declaration()')
  map('gi', 'vim.lsp.buf.implementation()')
  map('gr', 'vim.lsp.buf.references()')
  map('<leader>ca', 'vim.lsp.buf.code_action()')
  map('<leader>gh', 'vim.lsp.buf.signature_help()')
  map('<leader>rn', 'vim.lsp.buf.rename()')
  map('[d', 'vim.diagnostic.goto_prev()')
  map(']d', 'vim.diagnostic.goto_next()')

  if client.name ~= 'null-ls' then
    client.resolved_capabilities.document_formatting = false
  end

  if client.name == 'tsserver' then
    local ts_utils = safe_require 'nvim-lsp-ts-utils'
    if ts_utils then
      ts_utils.setup {}
      ts_utils.setup_client(client)
    end
  end
end

-- Update the LSP capabilities to support completions.
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local cmp_nvim_lsp = safe_require('cmp_nvim_lsp')
if cmp_nvim_lsp then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end
M.capabilities = capabilities

-- https://github.com/neovim/nvim-lspconfig/issues/115
function go_organize_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)

  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      au!
      au BufWritePre *.js,*.jsx,*.ts,*.tsx EslintFixAll
      au BufWritePre *.go lua go_organize_imports(1000)
      au BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 2000)
    augroup end
  ]]
end

return M
