syntax on
filetype plugin indent on

set autoindent
set backspace=indent,eol,start
set complete-=1
set expandtab
set laststatus=0
set nrformats-=octal
set number
set ruler
set scrolloff=1
set sessionoptions-=options
set shiftwidth=2
set showcmd
set sidescrolloff=5
set smarttab
set softtabstop=2
set tabstop=2
set wildmenu

set display+=lastline
set encoding=utf-8

" mkdir -p ~/.vim/{backup,swap,undo}
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

nnoremap K i<CR><Esc>

autocmd FileType make set noexpandtab
