" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

" Global options
" type "help :'option'" too see more about an option in use
set nocompatible
set number          " Print number lines
set noautochdir     " No automatic directory change on opening
set confirm         " Ask confirmation instead raising error
set nowrap          " No line wrapping
set ruler           " Show line and column of the cursor
set wildmenu

set expandtab       " Replace tab with spaces
set shiftwidth=4    " Use 4 spaces for (auto)indent
set tabstop=4       " Use 4 spaces for tab

set autoindent      " Copy indent from current line when starting a new line
set smartindent     " Smart indentation size on new line
set smarttab        " Read full description 

" Hotkeys' section
nnoremap <silent> <C-T> :tabnew<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-Left> :tabprev<CR>

" File type specific operations
autocmd FileType make call SetMakefileTabBehaviour()

" Custom functions' section
function SetMakefileTabBehaviour()
    " Function called on Makefile edit
    " Helps to set tab behaviour
    setlocal noexpandtab
    setlocal tabstop=4
    setlocal shiftwidth=4
endfunction

" Plugins' section
" Specify a directory for plugins
call plug#begin(stdpath('data').'/plugged')

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" Coc options

set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
