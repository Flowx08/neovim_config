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
map <tt> :ToggleTerm<cr>
map sl :HopWordCurrentLine<cr>
map sk <C-u>
map sj <C-d>
map gl :tabn<cr>
map gh :tabp<cr>
map gk :tabe<cr>
map gq :tabc<cr>
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

call plug#begin()

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Snippets are separated from the engine. Add this if you want them:
Plug 'rafamadriz/friendly-snippets'

" Autocompletion plugin
" ========================
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim' " rust tools
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'ray-x/lsp_signature.nvim'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" latex support
Plug 'lervag/vimtex'

" Github copilot
Plug 'github/copilot.vim'

" Comment plugin
Plug 'numToStr/Comment.nvim'

" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" TODO comments
Plug 'folke/todo-comments.nvim'

" Persistent sessions
Plug 'folke/persistence.nvim'

" Bufferline
" Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

" navigation in buffer
Plug 'stevearc/oil.nvim'

" Autopair parentheses and brackets
Plug 'windwp/nvim-autopairs'

" Show indentation level
Plug 'echasnovski/mini.indentscope'

" Log LSP messages
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

" hydra
Plug 'anuvyklack/hydra.nvim'

" Automatic formatting
Plug 'sbdchd/neoformat'

" Move to word
Plug 'ggandor/leap.nvim'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Tabline
" Plug 'romgrk/barbar.nvim'

" C/C++ Debugging

" Debugger split vertically not horizontally
let w:nvimgdb_termwin_command = "belowright vnew"
let w:nvimgdb_codewin_command = "vnew"
Plug 'sakhnik/nvim-gdb'
Plug 'mfussenegger/nvim-dap'

" Centering splits 
Plug 'shortcuts/no-neck-pain.nvim', { 'tag': '*' }

" Harpoon - quick file navigation
Plug 'ThePrimeagen/harpoon'

" Color schemes
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'nyoom-engineering/oxocarbon.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ellisonleao/gruvbox.nvim'
" Git stuff
Plug 'NeogitOrg/neogit'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()

" For autocompletion plugin
set completeopt=menu,menuone,noselect

"Automatically format files on save
" autocmd BufWritePre * Neoformat

luafile $HOME/.config/nvim/config.lua

" Hide tabline
set showtabline=0

colorscheme flowx08

