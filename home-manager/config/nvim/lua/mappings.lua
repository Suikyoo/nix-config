vim.g.mapleader = ","

local utils = require("utils")

-- allows for the use of ctrl-backspace to delete by conventional words
utils.noremap({"i", "c"}, "<C-h>", "<C-w>")
utils.inoremap("jk", "<ESC>")
utils.nnoremap("<s-l>", ":bn<CR>")
utils.nnoremap("<s-h>", ":bN<CR>")

-- some escape sequences I think?
utils.nnoremap("<c-j>", "<c-w>j")
utils.nnoremap("<c-k>", "<c-w>k")
utils.nnoremap("<c-h>", "<c-w>h")
utils.nnoremap("<c-l>", "<c-w>l")


utils.nnoremap("<leader>ev", ":e $MYVIMRC<CR>")
utils.nnoremap("<leader>sv", ":source $MYVIMRC<CR>")
utils.nnoremap("<leader>o", "o<ESC>k")
utils.nnoremap("<leader>cd", ":execute 'cd' fnameescape(expand('%:p:h'))<CR>")
utils.nnoremap("<leader>q", ":execute 'bd' fnameescape(expand('%'))<CR>")

utils.vnoremap('<leader>"', 'c"<ESC>pa"<ESC>')
utils.vnoremap("<leader>'", "c'<ESC>pa'<ESC>")

utils.tnoremap("<ESC>", "<C-\\><C-n>")
