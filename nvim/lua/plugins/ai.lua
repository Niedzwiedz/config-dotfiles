return {
  -- {
  --   "github/copilot.vim"
  -- },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = true,
    event = "CopilotChatToggle",
    dependencies = {
      'nvim-telescope/telescope-ui-select.nvim',
      { "zbirenbaum/copilot.lua", lazy = true },
      { "nvim-lua/plenary.nvim", lazy = true },   -- Required for HTTP requests and other utilities
    },
    opts = {
      -- Configuration options
      context = "buffer",
      question_header = '# DumDum ', -- Header to use for user questions
      answer_header = '# Bogusław ', -- Header to use for AI answers
      separator = '───', -- Separator to use in chat
      window = {
        width = 0.3,
        height = 0.3,
      },
      -- Disable the reset shortcut (Ctrl+r)
      mappings = {
        reset = {
          insert = "",
          normal = "",
        }
      },
      prompts = {
        MonAmi = {
          system_prompt =
          'You are a French-speaking coding assistant, please respond in english but with french friendly pleasantries as if you would talk with old friend. Do not use emojis',
        },
        LiberumVeto = {
          system_prompt =
          'You are a Polish-speaking coding assistant, please respond in english but with mannierism of polish nobility from 1600. Do not use emojis',
        },
        Yarrr = {
          system_prompt = 'You are fascinated by pirates, so please respond in pirate speak.',
        }
      },
      sticky = {
        '/LiberumVeto',
        '#file:./.github/copilot-introduction.md'
      },
    },
    -- Set up the key bindings
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      require("telescope").load_extension("ui-select")

      -- Define your custom keymappings here
      local keymaps = opts.keymaps or {
        ["<leader>cc"] = { cmd = "<cmd>CopilotChatToggle<CR>", desc = "Toggle CopilotChat" },
        ["<leader>ce"] = { cmd = "<cmd>CopilotChatExplain<CR>", desc = "Explain code" },
        ["<leader>ct"] = { cmd = "<cmd>CopilotChatTests<CR>", desc = "Generate tests" },
        ["<leader>cr"] = { cmd = "<cmd>CopilotChatReview<CR>", desc = "Code review" },
        ["<leader>cf"] = { cmd = "<cmd>CopilotChatFix<CR>", desc = "Fix issues" },
      }
      for key, map in pairs(keymaps) do
        vim.keymap.set("n", key, map.cmd, { desc = map.desc })
      end

      vim.api.nvim_create_autocmd('BufEnter', {
          pattern = 'copilot-*',
          callback = function()
              -- Set buffer-local options
              vim.opt_local.relativenumber = false
              vim.opt_local.number = false
              vim.opt_local.conceallevel = 0
          end
      })
    end,
    event = "BufRead",
  }
}
