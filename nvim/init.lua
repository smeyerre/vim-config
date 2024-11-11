-- Init
-- netrw should be disabled here for nvim-tree
-- ===========================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- ===========================

dofile('/usr/share/nvim/archlinux.lua') -- This line makes pacman-installed global Arch Linux vim packages work.
require('plugins') -- Load ~/.config/nvim/lua/plugins.lua
require('basic')
require('plugins_extended')
require('lsp')
require('completion')
