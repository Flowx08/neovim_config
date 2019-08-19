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
"set colorcolumn=100
set mouse=a
set hlsearch
set cursorline "highlight current line

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Hide the status line
set laststatus=1

" HARDMODE
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>

"autoresize pannels on resize event
autocmd VimResized * exe "normal \<c-w>="

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ Line:\ %l\ \ Column:\ %c
set clipboard+=unnamed

set nowrap "don't wrap lines

set history=1000	"remember more commands and search history	
set undolevels=1000	"use many much levels of undo

"Don't write a backup file
set nobackup		
set noswapfile

"Higlight matching parenthesis
set showmatch

"Stay quite
"set visualbell

"Pathogen
execute pathogen#infect()

"Format syntax
syntax on

"Color scheme
"colorscheme badwolf
"colorscheme mopkai
"colorscheme jelleybeans
colorscheme jelleybeans_flowx08
"colorscheme luna-term

"Change line number color
"highlight LineNr ctermbg=233

"Set background transparent
"highlight Normal ctermbg=None

"clang_complete
let g:clang_library_path="/usr/lib/llvm-3.8/lib/libclang.so.1"
set conceallevel=0
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'

let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_mac_num_candidates = 50
let g:ycm_max_num_identifier_candidates = 10

" Complete options (disable preview scratch window, longest removed to aways show menu)
set completeopt=menu,menuone

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"livepreview prewviewer
let g:livepreview_previewer = 'evince'

" Limit popup menu height
set pumheight=20

nmap <C-s> :w<cr>
nmap <C-m> :make<cr>
nmap <C-r> :%s/r1/r2/g
nmap <C-b> :NERDTreeToggle<cr>

"Move between pannels with arrow keys 
nmap <C-Up> :wincmd k<CR>
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
"nmap <C-Up> <Esc><C-U>
"nmap <C-Down> <Esc><C-D>
"imap <C-Up> <Esc><C-U>
"imap <C-Down> <Esc><C-D>
nmap <S-Left> <Esc>0
nmap <S-Right> <Esc>$
imap <S-Left> <Esc>0i
imap <S-right> <Esc>$i
