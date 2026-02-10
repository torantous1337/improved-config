-- ============================================================================
--  TREESITTER (Neovim 0.11+)
-- ============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    auto_install = true,
    config = function()
      -- Auto-enable treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
