-- ============================================================================
--  ██████╗ ██╗     ██╗███╗   ██╗ ██████╗     ██╗   ██╗██╗
--  ██╔══██╗██║     ██║████╗  ██║██╔════╝     ██║   ██║██║
--  ██████╔╝██║     ██║██╔██╗ ██║██║  ███╗    ██║   ██║██║
--  ██╔══██╗██║     ██║██║╚██╗██║██║   ██║    ██║   ██║██║
--  ██████╔╝███████╗██║██║ ╚████║╚██████╔╝    ╚██████╔╝██║
--  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚═╝
--  EXTRA BLING PLUGINS // MAKE IT LOOK INSANELY SICK
-- ============================================================================

return {
  -- ══════════════════════════════════════════════════════════════════════
  -- INCLINE (floating filenames at top of each window)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local devicons = require("nvim-web-devicons")
      
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          
          local buffer = {
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = modified and "bold,italic" or "bold" },
            { modified and "● " or "" },
          }
          
          return buffer
        end,
        window = {
          padding = 0,
          margin = { horizontal = 0, vertical = 0 },
          placement = { horizontal = "right", vertical = "top" },
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- CODEWINDOW (VSCode-style minimap)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "gorbit99/codewindow.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cond = function()
      return pcall(require, "nvim-treesitter.ts_utils")
    end,
    config = function()
      local codewindow = require("codewindow")
      local has_ts = pcall(require, "nvim-treesitter.ts_utils")
      codewindow.setup({
        auto_enable = false,
        minimap_width = 15,
        width_multiplier = 4,
        use_treesitter = has_ts,
        use_git = true,
        z_index = 1,
        screen_bounds = "lines",
        window_border = "single",
      })
      
      -- Add keymap for toggling minimap
      vim.keymap.set("n", "<leader>um", codewindow.toggle_minimap, { desc = "Toggle minimap" })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- WILDER (beautiful command line autocomplete)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = { "romgrk/fzy-lua-native" },
    cond = function()
      return vim.fn.has("python3") == 1
    end,
    config = function()
      local wilder = require("wilder")
      
      wilder.setup({ modes = { ":", "/", "?" } })
      
      -- Fuzzy finder
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })
      
      -- Popup menu with single borders
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlighter = wilder.lua_fzy_highlighter(),
          highlights = {
            border = "Normal",
          },
          border = "single",
          max_height = 15,
          min_height = 0,
          prompt_position = "top",
          reverse = 0,
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        }))
      )
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- CHEATSHEET (searchable keybind reference)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Cheatsheet",
    config = function()
      require("cheatsheet").setup({
        bundled_cheatsheets = true,
        bundled_plugin_cheatsheets = true,
        include_only_installed_plugins = true,
        telescope_mappings = {
          ["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
          ["<A-CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
          ["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
          ["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
        },
      })
      
      -- Add keymap for opening cheatsheet
      vim.keymap.set("n", "<leader>?", "<cmd>Cheatsheet<cr>", { desc = "Keybind cheatsheet" })
    end,
  },
}
