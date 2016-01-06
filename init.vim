set nocompatible
set ruler

set number
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set backspace=2
set statusline=2
set colorcolumn=100
set mouse=a
set hlsearch
set cursorline "highlight current line

set clipboard+=unnamed

set nowrap "don't wrap lines

set history=1000	"remember more commands and search history	
set undolevels=1000	"use many much levels of undo

"Don't write a backup file
set nobackup		
set noswapfile

"Stay quite
"set visualbell

"Pathogen
execute pathogen#infect()

"YouCompleteMe
let g:ycm_global_ycm_extra_conf = 'ycm_extra_conf.py'

"Syntastic
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

"Format syntax
syntax on

"Color scheme
colorscheme molokai

"Change line number color
highlight LineNr ctermbg=233

"Set background trasparent
"highlight Normal ctermbg=None

"YouCompleteMe configuration file path
let g:ycm_global_ycm_extra_conf = "~/.nvim/.ycm_extra_conf.py"

"YCM dont use TAB key
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

nmap <C-s> :w<cr>
nmap <C-m> :make<cr>
nmap <C-r> :%s/r1/r2/g
nmap <C-b> :NERDTreeToggle<cr>

"Move between pannels with arrow keys 
nmap <C-Up> :wincmd k<CR>
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
nmap <S-Left> <Esc>0
nmap <S-Right> <Esc>$
imap <S-Left> <Esc>0i
imap <S-right> <Esc>$i
