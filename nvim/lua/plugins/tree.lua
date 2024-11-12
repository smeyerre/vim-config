return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>nn', function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle tree" },
      { '<leader>nf', function() require("nvim-tree.api").tree.find_file() end, desc = "Find in tree" },
    },
    opts = {
      view = {
        width = 35,
      },
    }
  }
}
