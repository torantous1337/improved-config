-- ============================================================================
--  TELESCOPE
-- ============================================================================

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Disable treesitter highlighting in telescope previewers
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopePreviewerLoaded",
        callback = function()
          vim.wo.wrap = false
        end,
      })

      require("telescope").setup({
        defaults = {
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 10,
          prompt_prefix = "   ",
          selection_caret = " ",
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          preview = {
            treesitter = false,  -- Disable treesitter in preview
          },
        },
      })
    end,
  },
}
