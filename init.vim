set nocompatible
set ruler

set number
"set nonumber
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

"Format syntax
syntax on

"Color scheme
"colorscheme badwolf
"colorscheme mopkai
"colorscheme jelleybeans
colorscheme jelleybeans_flowx08
"colorscheme luna-term

"Change color of current number
hi CursorLineNr term=bold cterm=bold gui=bold guifg=#9999FF

"Dont highlight vertical line between buffers
hi vertsplit guifg=fg guibg=bg

"Set background transparent
highlight LineNr ctermbg=NONE guibg=NONE
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE

"Hide black lines ~ 
hi! EndOfBuffer ctermbg=black ctermfg=black guibg=black guifg=black

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
let g:ycm_rust_src_path = '/Users/carlomeroni/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'

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

" go lang bin path
let g:go_bin_path = expand("/usr/local/go")


"livepreview prewviewer
let g:livepreview_previewer = 'evince'

" Limit popup menu height
set pumheight=20

" disable s key
map s <Nop>

nmap <C-s> :w<cr>
nmap <C-m> :make<cr>
nmap <C-r> :%s/r1/r2/g
nmap <C-b> :NvimTreeToggle<cr>
nmap <C-g> :YcmCompleter GoToDefinition<cr>

" Find files using Telescope command-line sugar.
map ff :Telescope find_files<cr>
map <tt> :ToggleTerm<cr>
map sl :HopWordCurrentLine<cr>
map ss :HopWord<cr>
map sk <C-u>
map sj <C-d>

"Move between pannels with arrow keys 
nmap <C-Up> :wincmd k<CR>
nmap <C-Down> :wincmd j<CR>
nmap <C-Left> :wincmd h<CR>
nmap <C-Right> :wincmd l<CR>
"nmap <C-Up> <Esc><C-U>
"nmap <C-Down> <Esc><C-D>
"imap <C-Up> <Esc><C-U>
"imap <C-Down> <Esc><C-D>

"java autocompletion
" autocmd FileType java setlocal omnifunc=javacomplete#Complete
"
" Set the vertical split character to  a space (there is a single space after '\ ')
set fillchars+=vert:\ 

" hide status bar
hi StatusLine ctermbg=NONE

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'phaazon/hop.nvim'

" Autocompletion plugin
" ========================
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'

" For ultisnips users.
" Plug 'SirVer/ultisnips'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" For snippy users.
" Plug 'dcampos/nvim-snippy'
" Plug 'dcampos/cmp-snippy'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()

" For autocompletion plugin
set completeopt=menu,menuone,noselect

luafile /Users/carlo/.config/nvim/config.lua
