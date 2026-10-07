" Specify a directory for plugins call 
call plug#begin("~/vimfiles/autoload") 

Plug 'itchyny/lightline.vim' 
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'darrikonn/vim-gofmt'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'evanleck/vim-svelte', {'branch': 'main'}

Plug 'sbdchd/neoformat'
Plug 'dense-analysis/ale'


call plug#end() 

let mapleader = ","
let localleader = ","

syntax on

set mouse=a 
set nowrap 
set cursorline
set number
set relativenumber
set expandtab
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2 
set encoding=utf8 
set history=5000
set clipboard=unnamedplus
set shell=cmd.exe

echom ">^.^<"

noremap! <C-H> <C-w>
nnoremap <s-l> :bn<CR>
nnoremap <s-h> :bN<CR>
nnoremap <a-m> :e 
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>o o<ESC>k
nnoremap <leader><s-o> O<ESC>j
nnoremap <leader>cd :cd %:p:h<cr>
nnoremap <leader>q :bd %<cr>
nnoremap <leader>f :args *.py<cr>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <leader>n <cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>
inoremap jk <ESC>

" changes the nature of pasting while in visual mode. Pre-copies selection in
" --a-- named register instead of the unnamed register
vnoremap p "adP
vnoremap P p
vnoremap <leader>" c"<ESC>pa"<ESC>
vnoremap <leader>' c'<ESC>pa'<ESC>

tnoremap <ESC> <C-\><C-n>


" python config

" for py-- way of executing
autocmd FileType python nnoremap <F4> :w<CR>:term py "%"<CR>
autocmd FileType python inoremap <F4> <ESC>:w<CR>:term py %<CR>

" for the normal way of executing a program
autocmd FileType python nnoremap <F5> :w<CR>:! "%"<CR>
autocmd FileType python inoremap <F5> <ESC>:w<CR>:! %<CR>

" c config

" for sdl compile
autocmd FileType c  nnoremap <F4> :w<CR>:term gcc -std=c17 % -IC:\Users\judea\SDL2\x86_64-w64-mingw32\include -LC:\Users\judea\SDL2\x86_64-w64-mingw32\lib -Wall -lmingw32 -lSDL2main -lSDL2 -o main<CR>
autocmd FileType c inoremap  <F4> <ESC>:w<CR>:term gcc -std=c17 % -IC:\Users\judea\SDL2\x86_64-w64-mingw32\include -LC:\Users\judea\SDL2\x86_64-w64-mingw32\lib -Wall -lmingw32 -lSDL2main -lSDL2 -o main<CR>

" for normal compile
autocmd FileType c  nnoremap <F5> :w<CR>:term gcc -o %:r % && %:r.exe<CR>
autocmd FileType c inoremap  <F5> <ESC>:w<CR>:term gcc -o %:r % && %:r.exe<CR>

" typescript react
autocmd FileType typescriptreact nnoremap <F4> :w<CR>:term npm run android<CR>
autocmd FileType typescriptreact inoremap <F4> <ESC>:w<CR>:term npm run android<CR>

autocmd FileType typescriptreact nnoremap <F5> :w<CR>:term npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ && cd android && gradlew assembleRelease<CR>
autocmd FileType typescriptreact nnoremap <F5> :w<CR>:term npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ && cd android && gradlew assembleRelease<CR>

" javascript react
autocmd FileType javascriptreact nnoremap <F4> :w<CR>:term npm run android<CR>
autocmd FileType javascriptreact inoremap <F4> <ESC>:w<CR>:term npm run android<CR>

autocmd FileType javascriptreact nnoremap <F5> :w<CR>:term npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ && cd android && gradlew assembleRelease<CR>
autocmd FileType javascriptreact nnoremap <F5> :w<CR>:term npx react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res/ && cd android && gradlew assembleRelease<CR>

" terminal execution of javascript
autocmd FileType javascript nnoremap <F4> :w<CR>:term node "%"<CR>
autocmd FileType javascript inoremap <F4> <ESC>:w<CR>:term node %<CR>

" for the normal way of executing a program
autocmd FileType javascript nnoremap <F5> :w<CR>:! node "%"<CR>
autocmd FileType javascript inoremap <F5> <ESC>:w<CR>:! node %<CR>

" pre compile run
autocmd FileType java  nnoremap <F5> :w<CR>:term java %<CR>

let g:jsx_ext_required = 0 

let g:netrw_banner = 0
let g:netrw_liststyle = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 12

let g:vim_json_conceal=0
let g:vim_json_syntax_conceal=0
let g:markdown_syntax_conceal=0

let g:ale_fixers = {'javascript': ['prettier', 'eslint']}

if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
endif


set termguicolors


filetype plugin indent on

set nocompatible
set conceallevel=0
set cindent
set updatetime=750
set signcolumn=yes
set showtabline=2

set laststatus=2
set linespace=3
set cursorline

if has('termguicolors')
      set termguicolors
endif

let g:edge_style = 'aura'
let g:edge_better_performance = 1

colorscheme gruvbox-material
let g:lightline = {'colorscheme': 'gruvbox_material'}

let g:lightline.component_expand = {'buffers' : 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers' : 'tabsel'}

let g:lightline.active = {'left': [[ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ], ['bufnum']]}
let g:lightline.inactive = {'left' : [], 'right' : []}
let g:lightline.tabline = {'left' : [['buffers']], 'right' : [['close']]}

let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

" coc configuration

" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
" if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
