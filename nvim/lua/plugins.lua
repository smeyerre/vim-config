-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'dracula/vim', as = 'dracula'}

  use 'navarasu/onedark.nvim'

  use 'jlanzarotta/bufexplorer'

  use 'itchyny/lightline.vim'

  use 'preservim/nerdtree'

  use 'dense-analysis/ale'

  use 'tpope/vim-commentary'

  use 'terryma/vim-expand-region'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use { 'neoclide/coc.nvim', branch = 'release' }

end)
