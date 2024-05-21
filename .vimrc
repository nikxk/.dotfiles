" Enable source code highlighting
syntax on

" Set hybrid line numbers on
set number relativenumber

" Set tab width to 4 columns
set tabstop=4
" Use space characters instead of tabs
set expandtab

" Do not save backup files
set nobackup

" Ignore caps during search except if caps are used
set ignorecase smartcase

" Incrementally highlight matching characters in search and use highlighting, repaint screen cancelling search highlights
set incsearch hlsearch
nnoremap <C-L> :nohls<cr><C-L>
