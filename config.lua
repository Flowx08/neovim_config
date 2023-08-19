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


-- empty setup using defaults
require("nvim-tree").setup()

require("toggleterm").setup{
	size=25,
	shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
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
        -- fixed_width = 20

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

-- Setup mini.indentscope (show indents)
require('mini.indentscope').setup()

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
require("oil").setup()

local lsp_signature = require("lsp_signature")

lsp_signature_cfg = {
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

-- DAP = require('dap')
--
-- local Hydra = require('hydra')
--
-- Hydra({
--    name = 'Debug mode',
--    mode = 'n',
--    body = '<C-p>',
--    heads = {
--       { 'b', ':lua DAP.toggle_breakpoint()<CR>', { desc = 'breakpoint' }},
--       {'c', ':lua DAP.continue()<CR>', { desc = 'continue' }},
--       {'s', ':lua DAP.step_over()<CR>', { desc = 'step over' }},
--       {'i', ':lua DAP.step_into()<CR>', { desc = 'step into' }},
--       {'o', ':lua DAP.step_out()<CR>', { desc = 'step out' }},
--       {'e', ':lua DAP.run_last()<CR>', { desc = 'run last' }},
--       {'q', ':lua DAP.close()<CR>', { desc = 'close' }},
--       { 'h', 'h'},
--       { 'j', 'j'},
--       { 'k', 'k'},
--       { 'l', 'l'},
--    }
-- })

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
    width = 89,
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
      c = { fg = colors.active_color, bg = colors.innerbg },
    },
    replace = {
      a = { fg = colors.active_color, bg = colors.replace, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.active_color, bg = colors.innerbg },
    },
    normal = {
      a = { fg = colors.active_color, bg = colors.normal, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.active_color, bg = colors.innerbg },
    },
    insert = {
      a = { fg = colors.active_color, bg = colors.insert, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.active_color, bg = colors.innerbg },
    },
    command = {
      a = { fg = colors.active_color, bg = colors.command, gui = "bold" },
      b = { fg = colors.active_color, bg = colors.outerbg },
      c = { fg = colors.active_color, bg = colors.innerbg },
    },
  }
end

local function lualine_selected()
  return [[ ➤]]
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
    lualine_c = {},
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

-- Harpoon setup
-- mark file with Shift + M
vim.api.nvim_set_keymap("n", "<S-m>", "<cmd>lua require('harpoon.mark').add_file()<CR>", { noremap = true, silent = true })

-- Navigate to file number X with m + X
vim.api.nvim_set_keymap("n", "m1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "m2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "m3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "m4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "m5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "m6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", { noremap = true, silent = true })

-- Toggle quich menu with Ctrl + m
vim.api.nvim_set_keymap("n", "<C-m>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { noremap = true, silent = true })
