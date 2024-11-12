return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    cmd = "Telescope",  -- load only when Telescope command is used
    keys = {
      { '<leader>o', ':Telescope buffers<CR>', desc = "List buffers" },
    },
    opts = {
      defaults = {
        layout_strategy = 'vertical',
        sorting_strategy = 'ascending',
        mappings = {
          i = {
            ['<C-d>'] = require('telescope.actions').delete_buffer, -- delete buffer from picker
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- move in list
            ['<C-k>'] = require('telescope.actions').move_selection_previous,
            ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist, -- send selected to quickfix
          }
        }
      },
      pickers = {
        buffers = {
          sort_lastused = true,
          sort_mru = true,
          ignore_current_buffer = false,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer", -- delete buffer with Ctrl-d
            }
          }
        }
      }
    }
  }
}
