syntax on

set ignorecase  " Ignore cases when searching
set smartcase   " Use case sensitive when use upper case
set incsearch   " While searching though a file incrementally highlight matching characters as you type.
set showmatch   " Show matching words during search

set backspace=indent,eol,start " Allow backspacing over everything in insert mode.

set notimeout	    " wait up to 100ms after Esc for special key
set tabstop=4     " Set shift width to 4 spaces.
set shiftwidth=4    " Set tab width to 4 columns.
set expandtab       " Use space characters instead of tabs.
set autoindent
set nowrap

set number " show numbers on the left side
set relativenumber " add relative number to facilitate jumps

set showmode

let g:highlightedyank_highlight_duration = 100 "Duration of the yank
let g:highlightedyank_highlight_color = "rgba(160, 160, 160, 155)" "Color of the highlight

nnoremap <C-l> :nohlsearch<CR>
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv