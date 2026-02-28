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
          colors.bg = colors.None
        end,
      })
      vim.cmd([[colorscheme monoglow]]) -- activate the colorscheme
    end,
  },
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

