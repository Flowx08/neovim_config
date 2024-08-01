-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required
--  (otherwise wrong leader will be used)
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
      -- NOTE: `opts = {}` is the same as calling
      -- `require('fidget').setup({})`
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

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
    },
    lazy = true,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    "chrisgrieser/nvim-spider",
    lazy = true
  },
  'nvim-tree/nvim-web-devicons',
  'nvim-lua/plenary.nvim',
  {'akinsho/toggleterm.nvim', lazy = true},
  {'simrat39/rust-tools.nvim', lazy = true},
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'ray-x/lsp_signature.nvim',
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  {'lervag/vimtex', lazy = true},
  'github/copilot.vim',
  'm4xshen/smartcolumn.nvim',
  {'numToStr/Comment.nvim', lazy = true},
  'mg979/vim-visual-multi',
  'folke/todo-comments.nvim',
  'folke/persistence.nvim',
  {'stevearc/oil.nvim', lazy = true},
  'windwp/nvim-autopairs',
  'j-hui/fidget.nvim',
  {'anuvyklack/hydra.nvim', lazy = true},
  'sbdchd/neoformat',
  'ggandor/leap.nvim',
  'ojroques/vim-oscyank',
  'nvim-lualine/lualine.nvim',
  {'sakhnik/nvim-gdb', lazy = true},
  {'mfussenegger/nvim-dap', lazy = true},
  {'shortcuts/no-neck-pain.nvim', lazy = true},
  {'ThePrimeagen/harpoon', lazy = true},
  {'catppuccin/nvim', lazy = true},
  {'NeogitOrg/neogit', lazy = true, tag = 'v0.0.1'},
  'lewis6991/gitsigns.nvim',
}, {
  ui = {
    border = 'single'
  },
  config = {
    defaults = {
      lazy = true
    }
  },
})

function current_dir()
  local oil_path = require('oil').get_current_dir()
  if (oil_path == nil or oil_path == '') then
    return vim.fn.expand('%:p:h')
  else
    return oil_path
  end
end

function terminal_cdir()
  local wdir = vim.fn.getcwd()
  local cdir = current_dir()
  vim.api.nvim_set_current_dir(cdir)
  vim.cmd('terminal')
  vim.api.nvim_set_current_dir(wdir)
  -- Send A key to go insert mode
  vim.api.nvim_feedkeys('A', 'n', false)
end

function ResizeCurrentWindowAndDistributeRest(target_width)
  -- Get the total width of the Neovim
  local total_width = vim.api.nvim_eval('&columns')

  -- Resize the current window
  vim.api.nvim_win_set_width(0, target_width)

  -- Calculate the remaining width
  local remaining_width = total_width - target_width

  -- Count the number of windows except the current one
  local windows = vim.api.nvim_tabpage_list_wins(0)
  local num_other_windows = #windows - 1

  if num_other_windows <= 0 then return end  -- If there are no other windows, do nothing more

  -- Calculate the width to distribute to each of the other windows
  local width_per_window = math.floor(remaining_width / num_other_windows)

  -- Set the width for each of the other windows
  for _, win in pairs(windows) do
    if win ~= vim.api.nvim_get_current_win() then  -- Skip the current window
      vim.api.nvim_win_set_width(win, width_per_window)
    end
  end
end
