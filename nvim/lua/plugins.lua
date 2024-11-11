-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {'dracula/vim', as = 'dracula'}

  use 'navarasu/onedark.nvim'

  use 'jlanzarotta/bufexplorer'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }  -- optional icons
  }

  use 'preservim/nerdtree'

  use 'tpope/vim-commentary'

  use 'terryma/vim-expand-region'

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    'benlubas/molten-nvim',
    requires = {'3rd/image.nvim'},
    run = ':UpdateRemotePlugins',
    config = function()
      vim.g.molten_image_provider = "image.nvim"
      -- vim.g.molten_output_win_max_height = 20
    end
  }

  use '3rd/image.nvim'

  use {
    'quarto-dev/quarto-nvim',
    requires = {
      'jmbuhr/otter.nvim',
      'neovim/nvim-lspconfig'
    },
    -- ft = { 'quarto', 'markdown' },
  }

  use {
    'GCBallesteros/jupytext.nvim',
    config = function()
      require('jupytext').setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown"
      })
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- LSP Support
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

end)
