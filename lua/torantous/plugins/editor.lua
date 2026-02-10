-- ============================================================================
--  EDITOR:  File tree, autopairs, comments, DAP
-- ============================================================================

return {
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 35 },
        renderer = {
          highlight_git = true,
          indent_markers = { enable = true },
        },
      })
    end,
  },

  -- Autopairs
  { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup({}) end },

  -- Comments
  { "numToStr/Comment.nvim", config = function() require("Comment").setup({}) end },

  -- DAP
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function() require("dapui").setup() end,
  },
}
