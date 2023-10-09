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

" HARDMODE
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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

nmap <C-s> :w<cr>
nmap <C-r> :%s/r1/r2/g
nmap <C-b> :NvimTreeToggle<cr>

" Find files using Telescope command-line sugar.
map ff :Telescope find_files theme=ivy<cr>
" map fs :Telescope lsp_document_symbols theme=ivy<cr>
map fr :Telescope lsp_references theme=ivy<cr>
map fe :Telescope diagnostics theme=ivy<cr>
map fb :Telescope buffers theme=ivy<cr>
map fs :lua require("telescope.builtin").lsp_document_symbols({ symbols = { "class", "variable", "function", "enum" } })<cr>
map ft :TodoTelescope<cr>
map fl :bn<CR>
map fh :bp<CR>
map fd :ClangdSwitchSourceHeader<CR>
map fq :bd<CR>
map fc :Telescope colorscheme theme=ivy<cr>
map fg :lua require("telescope.builtin").live_grep(require('telescope.themes').get_ivy(), { search_dirs = { current_dir() }})<cr>
map <tt> :ToggleTerm<cr>
map sl :HopWordCurrentLine<cr>
map sk <C-u>
map sj <C-d>
map gl :tabn<cr>
map gh :tabp<cr>
map gk :tabe<cr>
map gq :tabclose<cr>
map vv :vsplit<cr>
map <C-e> :lua vim.diagnostic.open_float()<cr>
map ; :Oil<cr>
map ss :lua vim.lsp.buf.hover()<cr>
map sd :lua vim.lsp.buf.definition()<cr>
" map xl :bn<CR>
" map xh :bp<CR>
" Center horizontally
map zh zszH

" Delete without yanking
nnoremap d "_d
vnoremap d "_d

"Move between pannels with arrow keys
nmap <C-w-Up> :wincmd k<CR>
nmap <C-w-Down> :wincmd j<CR>
nmap <C-w-Left> :wincmd h<CR>
nmap <C-w-Right> :wincmd l<CR>

" Multiple cursors custom bindings
let g:VM_maps = {}
let g:VM_maps["Select Cursor Down"] = '<C-j>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<C-k>'        " start selecting up

" For autocompletion plugin
set completeopt=menu,menuone,noselect

"Automatically format files on save
" autocmd BufWritePre * Neoformat

luafile $HOME/.config/nvim/plugins.lua
luafile $HOME/.config/nvim/lua/custom/plugins/config.lua

" Hide tabline
set showtabline=0

colorscheme flowx08
