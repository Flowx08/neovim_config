-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1 -- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

-- Copilot setup
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.keymap.set('i', '<C-c>', '<Plug>(copilot-suggest)')

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = { border = "single" },
})

local telescope = require('telescope')
telescope.load_extension('fzf')

require("toggleterm").setup{
  size=25,
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  start_in_insert = true,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  open_mapping = [[tt]],
  -- This field is only relevant if direction is set to 'float'
}

require('nvim-web-devicons').setup({
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  };
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true;
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
})

require("smartcolumn").setup()

require('nvim-treesitter.configs').setup({
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})

require("luasnip.loaders.from_vscode").lazy_load()

-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      -- Define menu shorthand for different completion sources.
      local menu_icon = {
        nvim_lsp = "NLSP",
        nvim_lua = "NLUA",
        luasnip  = "LSNP",
        buffer   = "BUFF",
        path     = "PATH",
      }
      -- Set the menu "icon" to the shorthand for each completion source.
      item.menu = menu_icon[entry.source.name]

      -- Set the fixed width of the completion menu to 60 characters.
      local fixed_width = 60

      -- Set 'fixed_width' to false if not provided.
      fixed_width = fixed_width or false

      -- Get the completion entry text shown in the completion window.
      local content = item.abbr

      -- Set the fixed completion window width.
      if fixed_width then
        vim.o.pumwidth = fixed_width
      end

      -- Get the width of the current window.
      local win_width = vim.api.nvim_win_get_width(0)

      -- Set the max content width based on either: 'fixed_width'
      -- or a percentage of the window width, in this case 20%.
      -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
      local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

      -- Truncate the completion entry text if it's longer than the
      -- max content width. We subtract 3 from the max content width
      -- to account for the "..." that will be appended to it.
      if #content > max_content_width then
        item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
      else
        item.abbr = content .. (" "):rep(max_content_width - #content)
      end
      return item
    end,
  },
  window = {
    -- documentation = cmp.config.window.bordered(),
    -- completion = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(1),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    -- { name = 'nvim_lsp_signature_help' } -- For signature help
    -- { name = "lsp_signature"}
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Setup cland and python autocompletion
local lspconfig = require("lspconfig")

lspconfig.clangd.setup(
{
  cmd = {
    "clangd",
    "--completion-style=detailed",
    "--header-insertion=never",
    "--offset-encoding=utf-16",
  },
})

lspconfig.pyright.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.tsserver.setup({})
lspconfig.glslls.setup({})
lspconfig.bashls.setup({})

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Setup hop
-- require('hop').setup()
require('luasnip').filetype_extend("cpp", {"cpp"})

-- Setup nvim-comment
require('Comment').setup()

-- todo comments
require("todo-comments").setup()

-- Setup persistent sessions
require("persistence").setup()

-- Setup bufferline
-- require("bufferline").setup()

-- Setup nvim-autopairs (auto completion of brackets)
require("nvim-autopairs").setup()

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

require("fidget").setup()

-- Setup oil (navigation in buffer)
require("oil").setup({
  view_options = {
    show_hidden = true,
  }
})

local lsp_signature = require("lsp_signature")

local lsp_signature_cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 80, -- max_width of signature floating_window
  noice = false, -- set to true if you using noice to render markdown
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position. 
  -- can be either a number or function
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
  -- can be either number or function, see examples

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  toggle_key_flip_floatwin_setting = false, -- true: toggle float setting after toggle key pressed

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

lsp_signature.setup(lsp_signature_cfg)

DAP = require('dap')
DAP.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb", -- adjust as needed
  name = "lldb",
}

local lldb = {
  name = "Launch lldb",
  type = "lldb", -- matches the adapter
  request = "launch", -- could also attach to a currently running process
  program = function()
    return vim.fn.input(
    "Path to executable: ",
    vim.fn.getcwd() .. "/",
    "file"
    )
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runInTerminal = false,
}

DAP.configurations.c = {
  lldb -- different debuggers or more configurations can be used here
}


require('leap').add_default_mappings()
vim.keymap.del({'x', 'o'}, 'x')
vim.keymap.del({'x', 'o'}, 'X')

-- The below settings make Leap's highlighting closer to what you've been
-- used to in Lightspeed.

vim.api.nvim_set_hl(0, 'LeapBackdrop', {
  link = 'Comment',
}
) -- or some grey
vim.api.nvim_set_hl(0, 'LeapMatch', {
  -- For light themes, set to 'black' or similar.
  fg = 'white', bold = true, nocombine = true,
})

-- Lightspeed colors
-- primary labels: bg = "#f02077" (light theme) or "#ff2f87"  (dark theme)
-- secondary labels: bg = "#399d9f" (light theme) or "#99ddff" (dark theme)
-- shortcuts: bg = "#f00077", fg = "white"
-- You might want to use either the primary label or the shortcut colors
-- for Leap primary labels, depending on your taste.
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
  fg = 'red', bold = true, nocombine = true,
})
vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
  fg = 'blue', bold = true, nocombine = true,
})
-- Try it without this setting first, you might find you don't even miss it.
-- require('leap').opts.highlight_unlabeled_phase_one_targets = true

vim.api.nvim_set_hl(0, 'LeapMatch', {
  -- For light themes, set to 'black' or similar.
  fg = 'white', bold = true, nocombine = true,
})

vim.keymap.set('n', 'e', function ()
  local current_window = vim.fn.win_getid()
  require('leap').leap { target_windows = { current_window } }
end)

require("no-neck-pain").setup({
  width = 82,
  autocmds = {
    enableOnVimEnter = true,
  }
})

local lualine_theme = {}
lualine_theme.theme = function()
  local colors = {
    darkgray = "#000000",
    active_color = "#9999ff",
    white = "#dddddd",
    innerbg = nil,
    outerbg = nil,
    normal = "#7e9cd8",
    insert = "#7ed87e",
    visual = "#ffa066",
    replace = "#e46876",
    command = "#e6c384",
    hydra_color = "#aaff00",

  }
  return {
    inactive = {
      a = { fg = colors.white, bg = colors.outerbg, gui = "bold" },
      b = { fg = colors.white, bg = colors.outerbg },
      c = { fg = colors.white, bg = colors.innerbg },
    },
    visual = {
      a = { fg = colors.active_color, bg = colors.visual, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.hydra_color, bg = colors.innerbg },
    },
    replace = {
      a = { fg = colors.active_color, bg = colors.replace, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.hydra_color, bg = colors.innerbg },
    },
    normal = {
      a = { fg = colors.active_color, bg = colors.normal, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.hydra_color, bg = colors.innerbg },
    },
    insert = {
      a = { fg = colors.active_color, bg = colors.insert, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.hydra_color, bg = colors.innerbg },
    },
    command = {
      a = { fg = colors.active_color, bg = colors.command, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.hydra_color, bg = colors.innerbg },
    },
  }
end

local function lualine_selected()
  return [[ ➤]]
end

local function lualine_hydra()
  local mode_name = require('hydra.statusline').get_name()
  if mode_name == nil then
  end
  return ' ' .. mode_name .. ' '
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = lualine_theme.theme(),
    component_separators = { left = '', right = ' '},
    section_separators = { left = '', right = ' '},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  sections = {},
  inactive_sections = {},

  winbar = {
    lualine_a = {},
    lualine_b = {lualine_selected, {'filename', path=4,
    symbols = {
      modified = '[+]',      -- Text to show when the file is modified.
      readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '', -- Text to show for unnamed buffers.
      newfile = '[New]',     -- Text to show for newly created file before first write
    }}},
    lualine_c = {lualine_hydra},
    lualine_x = {'diagnostics','diff'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path=4,
    symbols = {
      modified = '[+]',      -- Text to show when the file is modified.
      readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '', -- Text to show for unnamed buffers.
      newfile = '[New]',     -- Text to show for newly created file before first write
    }}},
    lualine_x = {'diagnostics', 'diff'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Setup harpoon tabline colors
vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#333333')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=#9999ff')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#333333')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#9999ff')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=#9999ff')



-- Setup neogit
local neogit = require('neogit')
neogit.setup({})

-- Setup gitsigns
local gitsigns = require('gitsigns')
gitsigns.setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

local Hydra = require('hydra')

-- Harpoon setup
require("harpoon").setup({
  menu = {
    width = math.floor(vim.api.nvim_win_get_width(0) * 0.75),
  },
  tabline = true
})

local hint = [[
_m_: toggle menu   _f_: mark file  _q_: quit     _<ESC>_: quit
_1_: file 1        _2_: file 2     _3_: file 3   _4_: file 4
_5_: file 5        _6_: file 6     _7_: file 7   _8_: file 8
_9_: file 9
]]

Hydra({
  name = 'Harpoon mode',
  -- hint = hint,
  config = {
    buffer = bufnr,
    color = 'pink',
    invoke_on_body = true,
    hint = {
      border = 'rounded',
    },
    on_enter = function()
      vim.cmd 'set showtabline=2'
    end,
    on_exit = function()
      vim.cmd 'set showtabline=0'
    end,
  },
  mode = {'n'},
  body = "m",
  heads = {
    {'q', nil, { exit = true }},
    {'f', '<cmd>lua require("harpoon.mark").add_file()<CR>', {silent=true, exit=true}},
    {'<ESC>', nil, { exit = true }},
    {'m', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', {silent=true}},
    {'1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', {silent=true, exit=true}},
    {'2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', {silent=true, exit=true}},
    {'3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', {silent=true, exit=true}},
    {'4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', {silent=true, exit=true}},
    {'5', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', {silent=true, exit=true}},
    {'6', '<cmd>lua require("harpoon.ui").nav_file(6)<CR>', {silent=true, exit=true}},
    {'7', '<cmd>lua require("harpoon.ui").nav_file(7)<CR>', {silent=true, exit=true}},
    {'8', '<cmd>lua require("harpoon.ui").nav_file(8)<CR>', {silent=true, exit=true}},
    {'9', '<cmd>lua require("harpoon.ui").nav_file(9)<CR>', {silent=true, exit=true}},
  }
})

-- mark file with Shift + M
-- vim.api.nvim_set_keymap("n", "<S-m>", "<cmd>lua require('harpoon.mark').add_file()<CR>", { noremap = true, silent = true })
--
-- -- Toggle quich menu m
-- vim.api.nvim_set_keymap("n", "m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true, silent = true })
--
-- -- Navigate to file number X with m + X
-- vim.api.nvim_set_keymap("n", "m1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "m2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "m3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "m4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "m5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "m6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", { noremap = true, silent = true })


local hint = [[
_J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
_K_: prev hunk   _u_: undo last stage   _p_: preview hunk   _B_: blame show full 
^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
^
^ ^              _<Enter>_: Neogit              _q_: exit
]]
Hydra({
  name = 'Git mode',
  hint = hint,
  config = {
    buffer = bufnr,
    color = 'pink',
    invoke_on_body = true,
    hint = {
      border = 'rounded'
    },
    on_enter = function()
      vim.cmd 'mkview'
      vim.cmd 'silent! %foldopen!'
      vim.bo.modifiable = false
      gitsigns.toggle_signs(true)
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd 'loadview'
      vim.api.nvim_win_set_cursor(0, cursor_pos)
      vim.cmd 'normal zv'
      gitsigns.toggle_signs(false)
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
    end,
  },
  mode = {'n','x'},
  body = '<C-g>',
  heads = {
    { 'J',
    function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gitsigns.next_hunk() end)
      return '<Ignore>'
    end,
    { expr = true, desc = 'next hunk' } },
    { 'K',
    function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gitsigns.prev_hunk() end)
      return '<Ignore>'
    end,
    { expr = true, desc = 'prev hunk' } },
    { 's', ':Gitsigns stage_hunk<CR>', { silent = true, desc = 'stage hunk' } },
    { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
    { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
    { 'p', gitsigns.preview_hunk, { desc = 'preview hunk' } },
    { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
    { 'b', gitsigns.blame_line, { desc = 'blame' } },
    { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
    { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
    { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } },
    { 'q', nil, { exit = true, nowait = true, desc = 'exit' } },
  }
})

local hint_debug = [[
_ol_:  open LLDB    _og_:  open GDB          _r_:  run
_e_:   eval word    _fu_:  frame up          _fd_: frame down
_si_:  step inst    _sl_:  step line         _so_: step out
_c_:   continue     _b_:   toggle breakpoint _q_:  quit
]]

Hydra({
  name = 'Debug mode',
  mode = {'n', 'x'},
  hint = hint_debug,
  config = {
    buffer = bufnr,
    color = 'pink',
    invoke_on_body = true,
    hint = {
      border = 'rounded',
      type = "cmdline",
    },
  },
  body = '<S-d>',
  heads = {
    {'ol', ':GdbStartLLDB lldb ./bin/main\n', { desc = 'open lldb' }},
    {'og', ':GdbStartLLDB lldb ./bin/main\n', { desc = 'open gdb' }},
    {'r', ':GdbRun<CR>', { desc = 'run'}},
    {'b', ':GdbBreakpointToggle<CR>', { desc = 'toggle breakpoint'}},
    {'si', ':GdbStep<CR>', { desc = 'step insruction' }},
    {'sl', ':GdbNext<CR>', { dec = 'step line'}},
    {'so', ':GdbFinish<CR>', { dec = 'step out'}},
    {'c', ':GdbContinue<CR>', { desc = 'continue'}},
    {'e', ':GdbEvalWord<CR>', { desc = 'eval word'}},
    {'fu', ':GdbFrameUp<CR>', {desc = 'move frame up'}},
    {'fd', ':GdbFrameDown<CR>', {desc = 'move frame down'}},
    {'q', ':GdbDebugStop<CR>', { exit=true, nowait=true, desc = 'quit'}},
  }
})

function ToggleCHeaderSource()
  local file = vim.fn.expand('%:p')
  if file:match('.c$') then
    -- Switch to .h
    file = file:gsub('.c$', '.h')
  elseif file:match('.h$') then
    -- Switch to .c
    file = file:gsub('.h$', '.c')
  else
    print('Not a .c or .h file')
    return
  end

  if vim.fn.filereadable(file) == 1 then
    vim.cmd('edit ' .. file)
  else
    print('File does not exist: ' .. file)
  end
end

vim.api.nvim_create_user_command('ToggleCH', ToggleCHeaderSource, {})


