-- ============================================================================
--  LINTING & FORMATTING (Conform.nvim + Nvim-Lint)
--  "Safety Check" — strict formatting and static analysis for C/C++
-- ============================================================================

return {
  -- ══════════════════════════════════════════════════════════════════════
  -- CONFORM.NVIM (Auto-format on save)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          c = { "clang-format" },
          cpp = { "clang-format" },
          cuda = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- NVIM-LINT (Static analysis)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        c = { "cppcheck" },
        cpp = { "cppcheck" },
      }

      -- Fall back to clang-tidy if cppcheck is not available
      if vim.fn.executable("cppcheck") ~= 1 and vim.fn.executable("clang-tidy") == 1 then
        lint.linters_by_ft.c = { "clangtidy" }
        lint.linters_by_ft.cpp = { "clangtidy" }
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
