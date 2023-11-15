local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- HARDMODE
map('n', '<Up>', '<NOP>', opts)
map('n', '<Down>', '<NOP>', opts)
map('n', '<Left>', '<NOP>', opts)
map('n', '<Right>', '<NOP>', opts)

map('n', '<C-s>', ':w<cr>', opts)
map('n', '<C-r>', ':%s/r1/r2/g', opts)

-- Iterfaces to jump between files and withing file relevant locations
map('n', 'ff', ':Telescope find_files theme=ivy<cr>', opts)
map('n', 'fs', ':Telescope lsp_document_symbols theme=ivy<cr>', opts)
map('n', 'fr', ':Telescope lsp_references theme=ivy<cr>', opts)
map('n', 'fe', ':Telescope diagnostics theme=ivy<cr>', opts)
map('n', 'fb', ':e#<cr>', opts) -- back to previous file
map('n', 'fs', ':lua require("telescope.builtin").lsp_document_symbols({ symbols = { "class", "variable", "function", "enum" } })<cr>', opts)
map('n', 'fo', ':Telescope oldfiles theme=ivy<cr>', opts)
map('n', 'ft', ':TodoTelescope<cr>', opts)
map('n', 'fl', ':bn<CR>', opts)
map('n', 'fh', ':bp<CR>', opts)
map('n', 'fd', ':ClangdSwitchSourceHeader<CR>', opts)
map('n', 'fq', ':bd<CR>', opts)
map('n', 'fc', ':Telescope colorscheme theme=ivy<cr>', opts)
map('n', 'fg', ':lua require("telescope.builtin").live_grep(require("telescope.themes").get_ivy({ search_dirs = { current_dir() }}))<cr>', opts)
map('n', 'fm', ':Telescope marks theme=ivy<cr>', opts)

-- Terminal commands
-- Open floating terminal in current working directory
map('n', 'tt', ':ToggleTerm<cr>', opts)
-- Open termial as buffer in current oil or file directory
map('n', 'tb', ':lua terminal_cdir()<cr>', opts)
-- Open floating termial in current oil or file directory
map('n', 'tc', ':lua require("toggleterm.terminal").Terminal:new({dir=current_dir()}):toggle()<cr>', opts)
-- Open floating termial with lazygit
map('n', 'tg', ':TermExec cmd=lazygit<cr>', opts)

-- Quick movemnt withing file
map('n', 'sl', ':HopWordCurrentLine<cr>', opts)
map('n', 'sk', '<C-u>', opts)
map('n', 'sj', '<C-d>', opts)

-- Tabs
map('n', 'gl', ':tabn<cr>', opts)
map('n', 'gh', ':tabp<cr>', opts)
map('n', 'gk', ':tabe<cr>', opts)
map('n', 'gq', ':tabclose<cr>', opts)

map('n', 'vv', ':vsplit<cr>', opts)
map('n', 'vo', ':split<cr>', opts)
map('n', 'vn', ':NoNeckPain<cr>', opts)


map('n', '<C-e>', ':lua vim.diagnostic.open_float()<cr>', opts)

map('n', ';', ':Oil<cr>', opts)

map('n', 'ss', ':lua vim.lsp.buf.hover()<cr>', opts)
map('n', 'sd', ':lua vim.lsp.buf.definition()<cr>', opts)

-- Center horizontally
map('n', 'zh', 'zszH', opts)

-- Exit terminal mode with escape
map('t', '<Esc>', '<C-\\><C-n>', opts)

-- Delete without yanking
map('n', 'd', '"_d', opts)
map('v', 'd', '"_d', opts)

-- Move between pannels with arrow keys
map('n', '<C-w-Up>', ':wincmd k<CR>', opts)
map('n', '<C-w-Down>', ':wincmd j<CR>', opts)
map('n', '<C-w-Left>', ':wincmd h<CR>', opts)
map('n', '<C-w-Right>', ':wincmd l<CR>', opts)
