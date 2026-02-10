-- ============================================================================
--  LSP + MASON (Neovim 0.11+ native)
-- ============================================================================

return {
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "onsails/lspkind.nvim" },
  { "folke/neodev.nvim" }, -- Lua/Love2D typings support

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup({
        ui = { border = "rounded", icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "gopls", "bashls", "jsonls", "yamlls" },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local love_types = vim.fn.expand("~/.local/share/love-types")

      -- Neodev: add Love2D typings when a conf.lua is present
      require("neodev").setup({
        override = function(root_dir, opts)
          if vim.loop.fs_stat(root_dir .. "/conf.lua") then
            opts.library = opts.library or {}
            opts.library[love_types] = true
          end
        end,
      })

      local servers = { "lua_ls", "pyright", "gopls", "bashls", "jsonls", "yamlls" }

      for _, server in ipairs(servers) do
        local cfg = { capabilities = capabilities }

        if server == "lua_ls" then
          cfg.settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim", "love" } },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  love_types,
                },
              },
              telemetry = { enable = false },
              hint = { enable = true },
            },
          }
          cfg.root_dir = require("lspconfig.util").root_pattern("conf.lua", ".git")
        end

        vim.lsp.config[server] = cfg
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>fd", function() vim.lsp.buf.format({ async = true }) end, opts)
        end,
      })

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        float = { border = "rounded" },
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
      end
    end,
  },
}
