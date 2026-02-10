-- ============================================================================
--  GOLANG (simplified)
-- ============================================================================

return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
    },
    ft = { "go", "gomod" },
    build = ': lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = false,
        lsp_gofumpt = false,
        gofmt = "gofmt",
        linter = nil,  -- disable if you don't have golangci-lint
      })

      -- Simple keymaps
      vim.api. nvim_create_autocmd("FileType", {
        pattern = "go",
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<cr>", opts)
          vim.keymap.set("n", "<leader>gb", "<cmd>GoBuild<cr>", opts)
          vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", opts)
          vim.keymap.set("n", "<leader>ge", "<cmd>GoIfErr<cr>", opts)
          vim.keymap.set("n", "<leader>gf", "<cmd>GoFmt<cr>", opts)
          vim.keymap.set("n", "<leader>gi", "<cmd>GoImports<cr>", opts)
          vim.keymap.set("n", "<leader>ga", "<cmd>GoAlt<cr>", opts)
          vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", opts)
          vim.keymap.set("n", "<leader>gtj", "<cmd>GoAddTag json<cr>", opts)
        end,
      })
    end,
  },
}
