
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "mason-org/mason-lspconfig.nvim", opts = {}, dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig", }, },
  { "nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim"} },
  { "nvim-tree/nvim-tree.lua", dependencies = {"nvim-tree/nvim-web-devicons"} },
  { "nvim-lualine/lualine.nvim", dependencies = {"nvim-tree/nvim-web-devicons"} },
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
  },
  { 'saghen/blink.cmp', version = '1.*' },
  { 'arkav/lualine-lsp-progress' },
  { "rebelot/kanagawa.nvim" },
  { "ThomasVanRiel/nvim-notediscovery" },
  { "neovim/nvim-lspconfig" },
  --[[
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme('gruvbox-material')
    end
  },
  ]]

})

require("plugins.nvim-tree")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.nvim-treesitter")
require("plugins.mason-lspconfig")
require("plugins.blink")
require("plugins.kanagawa")
require("plugins.notes")
require("plugins.render-markdown")
