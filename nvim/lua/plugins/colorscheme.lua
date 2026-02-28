return {
  {
    "wnkz/monoglow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("monoglow").setup({
        on_colors = function(colors)
          colors.glow = "#FFA07A"
        end,
      })
      vim.cmd([[colorscheme monoglow]]) -- activate the colorscheme
    end,
  },
  -- {
  --   "RedsXDD/neopywal.nvim",
  --   name = "neopywal",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     no_underline = true, -- disable underline
  --     no_undercurl = true, -- disable undercurl
  --   },
  --   config = function(_, opts)
  --     local neopywal = require("neopywal")
  --     neopywal.setup(opts)
  --     vim.cmd([[colorscheme neopywal]]) -- activate the colorscheme
  --   end,
  -- },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "┆" },
        scope = {
          enabled = false,
        },
      })
    end,
  }
}

