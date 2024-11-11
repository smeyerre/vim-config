-- Telescope setup
vim.keymap.set('n', '<leader>o', ':Telescope buffers<CR>', { desc = "List buffers" })
require('telescope').setup{
  defaults = {
    layout_strategy = 'vertical',
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<C-d>'] = require('telescope.actions').delete_buffer,  -- Delete buffer from picker
        ['<C-j>'] = require('telescope.actions').move_selection_next,  -- Move in list
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-q>'] = require('telescope.actions').smart_send_to_qflist + require('telescope.actions').open_qflist,  -- Send selected to quickfix
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,  -- Sort by most recently used
      sort_mru = true,
      ignore_current_buffer = false,  -- Show current buffer in list
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",  -- Delete buffer with Ctrl-d
        }
      }
    }
  }
}

-- lualine Configuration
local function molten_status()
    if vim.bo.filetype == 'python' or vim.bo.filetype == 'markdown' or vim.bo.filetype == 'ipynb' then
        local status = require('molten.status')
        if status.initialized() == 'Molten' then
            local kernels = status.kernels()
            if kernels and kernels ~= "" then
                return '󱐋 Molten {' .. kernels .. '}'
            else
                return '󱐋 Molten'
            end
        end
    end
    return ''
end
require('lualine').setup {
  options = {
    theme = 'onedark',  -- similar to your 'one' colorscheme
  },
  sections = {
    lualine_x = {
      {
        molten_status,
        color = { fg = '#c91414' }
      },
      'encoding',
      'fileformat',
      'filetype'
    },
  }
}

-- nvim-tree Configuration
require("nvim-tree").setup({
    view = {
        width = 35,  -- only needed because different from default 30
    },
})
local api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>nn', api.tree.toggle, { desc = "Toggle tree" })
vim.keymap.set('n', '<leader>nf', api.tree.find_file, { desc = "Find in tree" })

-- Treesitter Configuration
require('nvim-treesitter.configs').setup({
  ensure_installed = "all",
  -- ensure_installed = { "angular", "arduino", "asm", "bash", "c", "c_sharp", "cmake", "comment", "commonlisp", "cpp", "css", "csv", "cuda", "diff", "dockerfile", "dot", "gdscript", "gdshader", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "glsl", "go", "goctl", "gdresource", "gomod", "gosum", "gotmpl", "gowork", "gpg", "graphql", "html", "htmldjango", "http", "java", "javascript", "jsdoc", "json", "json5", "kotlin", "latex", "lua", "luadoc", "lua_patterns", "make", "markdown", "markdown_inline", "nginx", "perl", "printf", "python", "r", "racket", "regex", "pip_requirements", "ruby", "rust", "scala", "scheme", "scss", "sql", "terraform", "tmux", "toml", "typescript", "vim", "vimdoc", "xml", "yaml", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = false,
      goto_next_start = {
        ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
      },
      goto_previous_start = {
        ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ib"] = { query = "@code_cell.inner", desc = "in block" },
        ["ab"] = { query = "@code_cell.outer", desc = "around block" },
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sbl"] = "@code_cell.outer",
      },
      swap_previous = {
        ["<leader>sbh"] = "@code_cell.outer",
      },
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",  -- start incremental selection
      node_incremental = "<CR>", -- increment selection
      node_decremental = "<BS>", -- decrement selection
      scope_incremental = "<TAB>", -- increment selection to scope
    },
  },
})

-- molten-nvim Configuration
-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false
-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true
-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true
-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true
vim.api.nvim_set_hl(0, "MoltenVirtualText", { link = "Type" })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", { desc = "open output window", silent = true })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "execute visual selection", silent = true })
vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })
-- if you work with html outputs:
vim.keymap.set("n", "<localleader>mx", ":MoltenOpenInBrowser<CR>", { desc = "open output in browser", silent = true })
-- Add new cell below current position
vim.keymap.set('n', '<localleader>nc', function()
    local save_pos = vim.fn.getpos('.') -- Save cursor position
    local old_search = vim.fn.getreg('/') -- Save current search register
    local found = vim.fn.search('^```$', 'W') -- First move to next code fence end
    if found == 0 then
        vim.fn.setpos('.', save_pos) -- If no fence found, restore position
    else
        if vim.fn.line('.') == vim.fn.line('$') then -- Check if we're at the last line of the file
            vim.api.nvim_put({'', ''}, 'l', true, true) -- Add a newline if we're at the end of the file
        else
            vim.cmd('normal! j') -- Move one line past the closing fence
        end
    end
    vim.api.nvim_put({'', '```python', '', '```', ''}, 'l', false, true) -- Insert the new cell
    vim.cmd('normal! k2k0') -- Move cursor to the empty line in the new cell
    vim.fn.setreg('/', old_search) -- Restore search register
    vim.cmd('nohlsearch') -- Clear search highlighting
end, { desc = "Add code cell below" })

-- image.nvim Configuration
-- Note: some settings required or recommended for Molten
require("image").setup({
  backend = "kitty",
  processor = "magick_rock",
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = 100, -- tweak to preference
  max_height = 12, -- ^
  max_width_window_percentage = math.huge,
  max_height_window_percentage = math.huge, -- this is necessary for a good experience
  window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})

-- Quarto Configuration
local ok, quarto = pcall(require, 'quarto')
if ok then
    quarto.setup({
        lspFeatures = {
            languages = { "python" },
            chunks = "all",
            diagnostics = {
                enabled = true,
                triggers = { "BufWritePost" },
            },
            completion = {
                enabled = true,
            },
        },
        keymap = {
            hover = "H",
            definition = "gd",
            rename = "<leader>rn",
            references = "gr",
            format = "<leader>gf",
        },
        codeRunner = {
            enabled = true,
            default_method = "molten",
        },
    })

    -- Add the recommended runner keymaps
    local ok_runner, runner = pcall(require, "quarto.runner")
    if ok_runner then
      vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all,   { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>rv",  runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })
    else
      vim.notify("Failed to load quarto runner", vim.log.levels.WARN)
    end
else
    vim.notify("Failed to load quarto", vim.log.levels.WARN)
end

-- nvim-lspconfig Configuration
require("lspconfig")["pyright"].setup({
    on_attach = on_attach,  -- if you have this function defined
    capabilities = capabilities,  -- if you have this defined
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedExpression = "none",
                },
            },
        },
    },
})



-- AUTOCOMMANDS
-- ====================================


-- Automatic output handling Configuration
-- automatically import output chunks from a jupyter notebook
-- tries to find a kernel that matches the kernel in the jupyter notebook
-- falls back to a kernel that matches the name of the active venv (if any)
local imb = function(e) -- init molten buffer
    vim.schedule(function()
        local kernels = vim.fn.MoltenAvailableKernels()
        local kernel_name = nil

        -- First try to get kernel from file
        local file = io.open(e.file, "r")
        if file then
            local ok, metadata = pcall(function()
                return vim.json.decode(file:read("*all"))["metadata"]
            end)
            file:close()

            if ok and metadata and metadata.kernelspec then
                kernel_name = metadata.kernelspec.name
            end
        end

        -- If no kernel found in file, try virtual env
        if not kernel_name or not vim.tbl_contains(kernels, kernel_name) then
            local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
            if venv ~= nil then
                kernel_name = string.match(venv, "/.+/(.+)")
            end
        end

        -- If we found a valid kernel, use it
        if kernel_name and vim.tbl_contains(kernels, kernel_name) then
            vim.cmd(("MoltenInit %s"):format(kernel_name))
        else
            -- Otherwise, prompt user to select a kernel
            vim.ui.select(kernels, {
                prompt = "Select a kernel for this notebook:",
                format_item = function(item)
                    return item
                end,
            }, function(choice)
                if choice then
                    vim.cmd(("MoltenInit %s"):format(choice))
                end
            end)
        end

        -- Import outputs regardless of kernel status
        vim.cmd("MoltenImportOutput")
    end)
end

-- Import outputs on file open
vim.api.nvim_create_autocmd("BufAdd", {
    pattern = { "*.ipynb" },
    callback = imb,
})

-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.ipynb" },
    callback = function(e)
        if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
            imb(e)
        end
    end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = { "*.ipynb" },
--     callback = function()
--         if require("molten.status").initialized() == "Molten" then
--             vim.cmd("MoltenExportOutput!")
--         end
--     end,
-- })

-- Export outputs on save
-- This export, in conjunction with the jupytext conversion, can make saving lag the editor for ~500ms, so autosave plugins can cause a bad experience.
vim.api.nvim_create_autocmd("BufWritePre", {  -- Changed from BufWritePost
    pattern = { "*.ipynb" },
    callback = function()
        if require("molten.status").initialized() == "Molten" then
            pcall(vim.cmd, "MoltenExportOutput!")  -- Added pcall to handle errors
        end
    end
})

-- Change Molten settings for Python files (show output in float, not virtual text)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    if require("molten.status").initialized() == "Molten" then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
      vim.fn.MoltenUpdateOption("virt_text_output", false)
    else
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_virt_text_output = false
    end
  end,
})

-- Reset Molten settings for notebook files (show output as virtual text)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.qmd", "*.md", "*.ipynb" },
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    if require("molten.status").initialized() == "Molten" then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
      -- vim.fn.MoltenUpdateOption("virt_text_output", true)
    else
      vim.g.molten_virt_lines_off_by_1 = true
      -- vim.g.molten_virt_text_output = true
    end
  end,
})

-- Handle quarto activation for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.schedule(function()
            local status_ok, quarto = pcall(require, "quarto")
            if status_ok then
                quarto.activate()
            else
                print("Could not load quarto for markdown file")
            end
        end)
    end,
})
