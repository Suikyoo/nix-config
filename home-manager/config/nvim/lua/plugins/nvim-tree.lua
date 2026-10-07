-- disable netrw at the very start of your init.lua


local api = require("nvim-tree.api")


local function toggle()
  api.tree.toggle({path = vim.fn.fnameescape(vim.fn.expand('%:p:h')), find_file = false, update_root = false, focus = true})
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>n", toggle, {noremap = true, silent = true, nowait = true})

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  git = {
    enable = false,
  },
  view = {
    width = 20,
  }
})

