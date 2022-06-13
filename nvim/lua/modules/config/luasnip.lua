return function()
  local ls = safe_require('luasnip')
  if not ls then
    return
  end

  -- Snippets
  for _, lang in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
    ls.add_snippets(lang, {
      ls.parser.parse_snippet('log', "console.log($1)$0"),
      ls.parser.parse_snippet('imr', "import React from 'react'"),
      ls.parser.parse_snippet('trans', "const [t] = useTranslation()"),
    }, { key = 'jtsx' })
  end

  -- Keymaps
  vim.keymap.set({ 'i', 's' }, '<c-k>', function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end, { silent = true })

  vim.keymap.set({ 'i', 's' }, '<c-j>', function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { silent = true })

  vim.keymap.set('i', '<c-l>', function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true })
end

