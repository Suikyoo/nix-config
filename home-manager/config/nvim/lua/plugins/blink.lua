require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ['<Tab>'] = { 'select_next', 'fallback'},
    ['<S-Tab>'] = { 'select_prev', 'fallback'},
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono'
  },

  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    documentation = { auto_show = false },
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  fuzzy = { implementation = "lua" }

})

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
