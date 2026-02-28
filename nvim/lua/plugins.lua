return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  --easier remapping
  {
    "b0o/mapx.nvim",
    config = function()
      require'mapx'.setup{ global = true }
      map("gn", ":bn<CR>")
      map("gp", ":bp<CR>")
      -- map("<C-n>", ":NvimTreeToggle<CR>")
    end,
  },
  'christoomey/vim-tmux-navigator',
  'kshenoy/vim-signature',
  'tpope/vim-commentary',
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Toggle Git" })
    end,
  },
  'tpope/vim-repeat',
  'bakudankun/pico-8.vim',
  'norcalli/nvim-colorizer.lua'
}


