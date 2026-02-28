return {
    -- {
    --     dir = "~/Work/neovim/doomtax.nvim",
    --     lazy = true,
    --     cmd = {
    --         "Doomtax",
    --         "DoomtaxToggle",
    --     },
    --     keys = {
    --         { "<leader>dt", "<cmd>Doomtax<CR>", mode = "v", desc = "Align assigments" }
    --     }
    -- },
    -- {
    --     "Niedzwiedz/doomtax.nvim",
    --     lazy = true,
    --     cmd = { "Doomtax" }
    -- },
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
  -- {
  --   "ThePrimeagen/git-worktree.nvim",
  --   lazy = true,
  --   config = function()
  --     require("git-worktree").setup({})

  --     local telescope = require("telescope")
  --     telescope.load_extension('git_worktree')
  --     local git_worktree = telescope.extensions.git_worktree


  --     vim.keymap.set('n', '<leader>gwl', git_worktree.git_worktrees, { desc = "Find Git worktrees" })
  --     vim.keymap.set('n', '<leader>gwc', git_worktree.create_git_worktree, { desc = "Create Git worktree" })
  --   end
  -- },
  {
    "kdheepak/lazygit.nvim",
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
  -- {
  --   'ThePrimeagen/harpoon',
  --   lazy = true,
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   config = function()
  --     local mark = require("harpoon.mark")
  --     vim.keymap.set('n', '<leader>mh', mark.add_file, { desc = "Add file to Harpoon" })

  --     mark.remove_file = function()
  --       mark.rm_file(mark.get_current_file())
  --     end

  --     vim.keymap.set('n', '<leader>rh', mark.rm_file, { desc = "Remove file from Harpoon" })

  --     local ui = require("harpoon.ui")
  --     vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })

  --     require("telescope").load_extension('harpoon')
  --     vim.keymap.set('n', '<leader>fh', ":Telescope harpoon marks<CR>", { desc = "Find Harpoon marks" })
  --   end,
  -- },
  {
    'mbbill/undotree',
    lazy = true,
    config = function()
      vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end,
  }
}
