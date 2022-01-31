local nvim_lsp = require('lspconfig')

local function buf_set_keymap(bufnr, mode, trigger, cmd)
  vim.api.nvim_buf_set_keymap(bufnr, mode, trigger, cmd, {
    noremap=true,
    silent=true
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function map(...) buf_set_keymap(bufnr, ...) end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  -- map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
  map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')
end

-- TypeScript
local ts_utils = require("nvim-lsp-ts-utils")

nvim_lsp.tsserver.setup {
  init_options = ts_utils.init_options,
  on_attach = function (client, bufnr)
    on_attach(client, bufnr)

    -- TS LSP Utils
    ts_utils.setup({
      enable_import_on_completion = true,
      update_imports_on_move = true,
      auto_inlay_hints = false,
    })
    ts_utils.setup_client(client)

    -- Keymap
    local function map(...) buf_set_keymap(bufnr, ...) end
    map("n", "<leader>o", ":TSLspOrganize<CR>")
    map("n", "<leader>rn", ":TSLspRenameFile<CR>")
    map("n", "<leader>ia", ":TSLspImportAll<CR>", opts)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}
