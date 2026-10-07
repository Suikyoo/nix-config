local utils = require("utils")
local builtin_pickers = require("telescope.builtin")
local actions = require("telescope.actions")


require("telescope").setup({
  defaults = {
    layout_strategy = 'horizontal',
    sorting_strategy = 'ascending',
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      height = 0.6,
      width = 0.8,
      prompt_position = 'top',
      preview_width = 0
    },
    mappings = {
      i = {
        ["<CR>"] = actions.select_default,
      },
      n = {
        ["<CR>"] = actions.select_default,
      }
    }
  }
})

utils.nnoremap("<leader>ff", builtin_pickers.find_files)
utils.nnoremap("<leader>fg", builtin_pickers.live_grep)
utils.nnoremap("<leader>fb", builtin_pickers.buffers)
utils.nnoremap("<leader>fd", builtin_pickers.lsp_references)
