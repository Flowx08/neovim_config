set nocompatible
set ruler

set number
"set nonumber
set autoindent
set tabstop=2
"set softtabstop=4
set shiftwidth=2
set smarttab
set expandtab "set noexpandtab set backspace=2 set colorcolumn=100
set mouse=a
set hlsearch
set cursorline "highlight current line
"set scrolloff=9999 "keep cursor in the middle of the screen

set ai "Auto indent
set si "Smart indent
set nowrap "don't wrap lines

" Hide the status line
" set laststatus=1
set noshowmode
set noruler
set laststatus=0
set noshowcmd

"autoresize pannels on resize event
autocmd VimResized * exe "normal \<c-w>="

" Format the status line
set statusline=\ %t
set clipboard+=unnamed

set history=1000	"remember more commands and search history
set undolevels=1000	"use many much levels of undo

"Don't write a backup file
set nobackup
set noswapfile

"Higlight matching parenthesis
set showmatch

"Stay quite
"set visualbell

"Format syntax
syntax on

" Set the vertical split character to  a space (there is a single space after '\ ')
set fillchars+=vert:\ 

" Limit popup menu height
set pumheight=30
set pumwidth=60

" Multiple cursors custom bindings
let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<C-j>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<C-k>'        " start selecting up

" For autocompletion plugin
set completeopt=menu,menuone,noselect

"Automatically format files on save
" autocmd BufWritePre * Neoformat