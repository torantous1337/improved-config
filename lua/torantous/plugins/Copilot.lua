-- ============================================================================
--  GITHUB COPILOT
-- ============================================================================

return {
  -- Official Copilot plugin
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Disable default Tab mapping (we'll set our own)
      vim.g.copilot_no_tab_map = true
      
      -- Accept suggestion with Ctrl+y
      vim.keymap.set("i", "<C-y>", 'copilot#Accept("<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion",
      })
      
      -- Navigate suggestions
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Prev Copilot suggestion" })
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot" })
      
      -- Enable for specific filetypes (optional - enabled everywhere by default)
      vim.g.copilot_filetypes = {
        ["*"] = true,
        ["markdown"] = true,
        ["yaml"] = true,
      }
    end,
  },

  -- (Optional) Copilot Chat - for chat/explain/review features
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
    },
    build = "make tiktoken",  -- Only on MacOS or Linux
    config = function()
      require("CopilotChat").setup({
        window = {
          layout = "vertical",
          width = 0.4,
        },
      })
    end,
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code", mode = { "n", "v" } },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "Review code", mode = { "n", "v" } },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "Fix code", mode = { "n", "v" } },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize code", mode = { "n", "v" } },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests", mode = { "n", "v" } },
    },
  },
}
