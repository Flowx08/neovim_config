-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

'nvim-tree/nvim-web-devicons',
'nvim-tree/nvim-tree.lua',
'nvim-lua/plenary.nvim',
'akinsho/toggleterm.nvim',
'simrat39/rust-tools.nvim',
'hrsh7th/cmp-buffer',
'hrsh7th/cmp-path',
'hrsh7th/cmp-cmdline',
'ray-x/lsp_signature.nvim',
'hrsh7th/cmp-vsnip',
'hrsh7th/vim-vsnip',
'lervag/vimtex',
'github/copilot.vim',
'numToStr/Comment.nvim',
'mg979/vim-visual-multi',
'folke/todo-comments.nvim',
'folke/persistence.nvim',
'stevearc/oil.nvim',
'windwp/nvim-autopairs',
'echasnovski/mini.indentscope',
'j-hui/fidget.nvim',
'anuvyklack/hydra.nvim',
'sbdchd/neoformat',
'ggandor/leap.nvim',
'nvim-lualine/lualine.nvim',
'sakhnik/nvim-gdb',
'mfussenegger/nvim-dap',
'shortcuts/no-neck-pain.nvim',
'ThePrimeagen/harpoon',
'folke/tokyonight.nvim',
'rebelot/kanagawa.nvim',
'nyoom-engineering/oxocarbon.nvim',
'catppuccin/nvim',
'ellisonleao/gruvbox.nvim',
'NeogitOrg/neogit',
'lewis6991/gitsigns.nvim',
}, {
  ui = {
    border = 'single'
  }
})
