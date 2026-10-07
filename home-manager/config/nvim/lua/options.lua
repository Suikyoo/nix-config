vim.opt.mouse = "a"
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.encoding = "utf8"
vim.opt.updatetime = 500
vim.opt.history = 5000
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.opt.signcolumn = "yes"
vim.opt.showtabline = 2
vim.opt.laststatus = 2
vim.opt.linespace = 3
vim.opt.cursorline = true
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  }
}
