local mason = require("mason-lspconfig")
local utils = require("utils")

mason.setup({
  auto_install = false
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function ()
    utils.nnoremap("gd", vim.lsp.buf.definition)
  end
})
