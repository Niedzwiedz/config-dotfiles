return {
  {
      'nvim-mini/mini.align',
      version = false,
      config = function()
        vim.keymap.set('x', '<leader>rs', ':s/\\S\\zs  \\+/ /g<CR>', { desc = 'Remove extra spaces' })

        require('mini.align').setup()
      end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "kdheepak/lazygit.nvim",
    config = function()
        vim.g.lazygit_theme = false
    end,
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "Toggle LazyGit" }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function ()
      local gitsigns = require("gitsigns")
      gitsigns.setup({
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      })
      vim.keymap.set('n', '<leader>gh', gitsigns.preview_hunk, { desc = "Git preview hunk" })
    end
  },
  {
    'windwp/nvim-spectre',
    lazy = true,
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('spectre').setup()
    end,
  },
  {
    'mbbill/undotree',
    lazy = true,
    config = function()
      vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end,
  }
}
