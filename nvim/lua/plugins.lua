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

end)
