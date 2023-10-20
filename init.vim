source $HOME/.config/nvim/options.vim
luafile $HOME/.config/nvim/plugins.lua
luafile $HOME/.config/nvim/lua/custom/plugins/setup.lua
luafile $HOME/.config/nvim/keymaps.lua

" Hide tabline (needs to be after lualine plugin setup)
set showtabline=0

colorscheme flowx08
