set number
set autoindent
set bs=2
set expandtab
set wildmenu
set t_ut=""
set foldmethod=syntax

execute pathogen#infect()
syntax on 
filetype plugin indent on
filetype indent on
set sw=4
set tabstop=4
au BufReadPost *.sm set syntax=c
color ron
if &diff
    color murphy
endif
highlight PreProc guibg = Black
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
