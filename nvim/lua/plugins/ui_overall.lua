return {
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files"})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find text in project"})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers"})
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Find buffers"})
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "Find in current buffer"})
      vim.keymap.set('n', '<leader>tcc', builtin.colorscheme, { desc = "Telescope colorscheme"})
      vim.keymap.set('n', '<leader>tgh', builtin.git_bcommits, { desc = "Telescope git commits for buffer"})
      vim.keymap.set('n', '<leader>ttr', builtin.treesitter, { desc = "Telescope treesitter symbols"})
      vim.keymap.set('n', '<leader>rr', builtin.registers, { desc = "Telescope registers"})

      local actions = require('telescope.actions')
      require("telescope").setup {
        defaults = {
          selection_caret = "➤ ",
          entry_prefix = "  ",
          initial_mode = "insert",
          layout_strategy = "flex",
          layout_config = {
            horizontal = { mirror = false },
            vertical = { mirror = false },
            flex = { flip_columns = 150 },
          },
          sorting_strategy = "descending",
          scroll_strategy = "cycle",
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<C-u>"] = false,
            },
          },
        },
        pickers = {
          buffers = {
            theme = "ivy",
            sort_lastused = true,
            ignore_current_buffer = true,
            initial_mode = 'normal',
            sort_mru = true,
            layout_config = {
              height = 10,
            },
            mappings = {
              i = {
                ["<C-d>"] = actions.delete_buffer,
              },
              n = {
                ["dd"] = actions.delete_buffer,
              },
            },
          },
          registers = {
            theme = "ivy",
            sort_mru = true,
            initial_mode = 'normal',
            layout_config = {
              height = 10,
            },
            mappings = {
              n = {
                ["c"] = actions.edit_register,
              },
            },
          },
        }
      }
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function ()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown{}
          }
        }
      }

      require("telescope").load_extension("ui-select")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "wnkz/monoglow.nvim",
    },
    config = function()
        local bg = vim.api.nvim_get_hl(0, {name = 'Normal'})['background']
        require('lualine').setup {
          options = {
            theme = 'auto',
            section_separators = '',
            component_separators = '',
            show_filename_only = false,   -- Shows shortened relative path when set to false.
            hide_filename_extension = false,   -- Hide filename extension when set to true.
            show_modified_status = true, -- Shows indicator when the buffer is modified.
          },
          sections = {
             -- lualine_a = {'mode'},
             lualine_a = { {'mode', fmt = function(res) return res:sub(1,1) end} },
             lualine_b = {'branch', 'diff', 'diagnostics'},
             lualine_c = {
               { 'filename', path = 1, shorting_target = 50 },
               { function() return "[" .. #vim.fn.getbufinfo({buflisted = true}) .. "]" end,
               color = { bg = bg, fg = '#a6ffc9'}},
             },
             lualine_x = {
               'encoding',
               'fileformat',
               'filetype'
             },
             lualine_y = {'progress'},
             lualine_z = {'location'}
          },
        }
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function ()
      require("oil").setup(
        {
          view_options = {
            show_hidden = true,
          },
          keymaps = {
              ["g?"] = { "actions.show_help", mode = "n" },
              ["<CR>"] = "actions.select",
              ["<C-s>"] = { "actions.select", opts = { vertical = true } },
              ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
              ["<C-t>"] = { "actions.select", opts = { tab = true } },
              ["<C-p>"] = "actions.preview",
              ["<C-c>"] = { "actions.close", mode = "n" },
              ["-"] = { "actions.parent", mode = "n" },
              ["_"] = { "actions.open_cwd", mode = "n" },
              ["`"] = { "actions.cd", mode = "n" },
              ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
              ["gs"] = { "actions.change_sort", mode = "n" },
              ["gx"] = "actions.open_external",
              ["g."] = { "actions.toggle_hidden", mode = "n" },
              ["g\\"] = { "actions.toggle_trash", mode = "n" },
          },
          use_default_keymaps = false,
        }
      )
      vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = {
        window = {
          normal_hl = "Comment",      -- Base highlight group in the notification window
          winblend = 0                  -- Blend level of the fidget window. (0 - 100)
        },
      }
      -- Options related to LSP progress subsystem
      -- progress = {
      --   poll_rate = 0,                -- How and when to poll for progress messages
      --   suppress_on_insert = false,   -- Suppress new messages while in insert mode
      --   ignore_done_already = false,  -- Ignore new tasks that are already complete
      --   ignore_empty_message = false, -- Ignore new tasks that don't contain a message
      --   clear_on_detach =             -- Clear notification group when LSP server detaches
      --     function(client_id)
      --       local client = vim.lsp.get_client_by_id(client_id)
      --       return client and client.name or nil
      --     end,
      --   notification_group =          -- How to get a progress message's notification group key
      --     function(msg) return msg.lsp_client.name end,
      --   ignore = {},
      -- }
    },
  }
}
