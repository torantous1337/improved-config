return {
  -- ══════════════════════════════════════════════════════════════════════
  -- CATPPUCCIN THEME (vibrant + custom highlights)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.19,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "bold" },
          functions = { "bold" },
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = { "bold" },
          booleans = { "bold", "italic" },
          properties = {},
          types = { "bold" },
          operators = {},
        },
        color_overrides = {
          mocha = {
            -- Make it more vibrant
            rosewater = "#f5e0dc",
            flamingo = "#f2cdcd",
            pink = "#f5c2e7",
            mauve = "#cba6f7",
            red = "#f38ba8",
            maroon = "#eba0ac",
            peach = "#fab387",
            yellow = "#f9e2af",
            green = "#a6e3a1",
            teal = "#94e2d5",
            sky = "#89dceb",
            sapphire = "#74c7ec",
            blue = "#89b4fa",
            lavender = "#b4befe",
            text = "#cdd6f4",
            subtext1 = "#bac2de",
            subtext0 = "#a6adc8",
            overlay2 = "#9399b2",
            overlay1 = "#7f849c",
            overlay0 = "#6c7086",
            surface2 = "#585b70",
            surface1 = "#45475a",
            surface0 = "#313244",
            base = "#1e1e2e",
            mantle = "#181825",
            crust = "#11111b",
          },
        },
        custom_highlights = function(colors)
          return {
            -- Vibrant cursor line
            CursorLine = { bg = colors.surface0 },
            CursorLineNr = { fg = colors.mauve, bold = true },
            LineNr = { fg = colors.overlay0 },

            -- Pumped up search
            Search = { bg = colors.yellow, fg = colors.base, bold = true },
            IncSearch = { bg = colors.peach, fg = colors.base, bold = true },
            CurSearch = { bg = colors.red, fg = colors.base, bold = true },

            -- Vibrant matching parens
            MatchParen = { fg = colors.peach, bg = colors.surface1, bold = true },

            -- Better visual selection
            Visual = { bg = colors.surface1, bold = true },
            VisualNOS = { bg = colors.surface1 },

            -- Pumped diagnostics
            DiagnosticVirtualTextError = { fg = colors.red, bg = colors.surface0, italic = true },
            DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.surface0, italic = true },
            DiagnosticVirtualTextInfo = { fg = colors.sky, bg = colors.surface0, italic = true },
            DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.surface0, italic = true },

            -- Floating windows
            NormalFloat = { bg = colors.mantle },
            FloatBorder = { fg = colors.mauve, bg = colors.mantle },
            FloatTitle = { fg = colors.peach, bg = colors.mantle, bold = true },

            -- Telescope
            TelescopeBorder = { fg = colors.mauve, bg = colors.mantle },
            TelescopeNormal = { bg = colors.mantle },
            TelescopePreviewBorder = { fg = colors.green, bg = colors.mantle },
            TelescopePreviewNormal = { bg = colors.mantle },
            TelescopePreviewTitle = { fg = colors.base, bg = colors.green, bold = true },
            TelescopePromptBorder = { fg = colors.peach, bg = colors.surface0 },
            TelescopePromptNormal = { bg = colors.surface0 },
            TelescopePromptTitle = { fg = colors.base, bg = colors.peach, bold = true },
            TelescopeResultsBorder = { fg = colors.mauve, bg = colors.mantle },
            TelescopeResultsTitle = { fg = colors.base, bg = colors.mauve, bold = true },
            TelescopeSelection = { bg = colors.surface1, fg = colors.text, bold = true },

            -- Pmenu (completion)
            Pmenu = { bg = colors.mantle, fg = colors.text },
            PmenuSel = { bg = colors.surface1, fg = colors.text, bold = true },
            PmenuSbar = { bg = colors.surface0 },
            PmenuThumb = { bg = colors.mauve },

            -- Git signs vibrant
            GitSignsAdd = { fg = colors.green },
            GitSignsChange = { fg = colors.peach },
            GitSignsDelete = { fg = colors.red },

            -- Indent guides
            IblIndent = { fg = colors.surface0 },
            IblScope = { fg = colors.mauve },

            -- Which-key
            WhichKey = { fg = colors.mauve, bold = true },
            WhichKeyGroup = { fg = colors.peach },
            WhichKeyDesc = { fg = colors.text },
            WhichKeySeparator = { fg = colors.overlay0 },
            WhichKeyFloat = { bg = colors.mantle },
            WhichKeyBorder = { fg = colors.mauve, bg = colors.mantle },

            -- Nvim Tree
            NvimTreeNormal = { bg = colors.mantle },
            NvimTreeNormalNC = { bg = colors.mantle },
            NvimTreeWinSeparator = { fg = colors.mantle, bg = colors.mantle },
            NvimTreeFolderIcon = { fg = colors.peach },
            NvimTreeFolderName = { fg = colors.blue },
            NvimTreeOpenedFolderName = { fg = colors.peach, bold = true },
            NvimTreeRootFolder = { fg = colors.mauve, bold = true },
            NvimTreeSpecialFile = { fg = colors.yellow, bold = true },
            NvimTreeGitDirty = { fg = colors.peach },
            NvimTreeGitNew = { fg = colors.green },
            NvimTreeGitDeleted = { fg = colors.red },

            -- Noice
            NoiceCmdline = { bg = colors.surface0 },
            NoiceCmdlineIcon = { fg = colors.peach },
            NoiceCmdlinePopup = { bg = colors.mantle },
            NoiceCmdlinePopupBorder = { fg = colors.mauve },
            NoicePopup = { bg = colors.mantle },
            NoicePopupBorder = { fg = colors.mauve },

            -- Notify
            NotifyBackground = { bg = colors.mantle },
            NotifyERRORBorder = { fg = colors.red },
            NotifyERRORIcon = { fg = colors.red },
            NotifyERRORTitle = { fg = colors.red, bold = true },
            NotifyWARNBorder = { fg = colors.yellow },
            NotifyWARNIcon = { fg = colors.yellow },
            NotifyWARNTitle = { fg = colors.yellow, bold = true },
            NotifyINFOBorder = { fg = colors.green },
            NotifyINFOIcon = { fg = colors.green },
            NotifyINFOTitle = { fg = colors.green, bold = true },

            -- Bufferline
            BufferLineFill = { bg = colors.crust },
            BufferLineBackground = { bg = colors.mantle, fg = colors.overlay1 },
            BufferLineBufferSelected = { bg = colors.base, fg = colors.text, bold = true, italic = false },
            BufferLineIndicatorSelected = { fg = colors.peach },
          }
        end,
        integrations = {
          alpha = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = { enabled = true },
          treesitter = true,
          which_key = true,
          indent_blankline = { enabled = true, colored_indent_levels = true },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "NONE" },
          noice = true,
          notify = true,
          mini = true,
          dap = { enabled = true, enable_ui = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- LUALINE (sick statusline)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      -- Custom components
      local mode_icon = {
        "mode",
        fmt = function(str)
          local mode_icons = {
            NORMAL = " ",
            INSERT = " ",
            VISUAL = "󰈈 ",
            ["V-LINE"] = "󰈈 ",
            ["V-BLOCK"] = "󰈈 ",
            REPLACE = " ",
            COMMAND = " ",
            TERMINAL = " ",
          }
          return (mode_icons[str] or " ") .. str
        end,
      }

      local diff = {
        "diff",
        symbols = { added = " ", modified = "󰝤 ", removed = " " },
        colored = true,
        diff_color = {
          added = { fg = mocha.green },
          modified = { fg = mocha.peach },
          removed = { fg = mocha.red },
        },
      }

      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
        colored = true,
        diagnostics_color = {
          error = { fg = mocha.red },
          warn = { fg = mocha.yellow },
          info = { fg = mocha.sky },
          hint = { fg = mocha.teal },
        },
      }

      local filetype_icon = {
        "filetype",
        icon_only = true,
        colored = true,
        padding = { left = 1, right = 0 },
      }

      local filename = {
        "filename",
        path = 1,
        symbols = {
          modified = " ●",
          readonly = " ",
          unnamed = " [No Name]",
          newfile = " [New]",
        },
      }

      local lsp_info = {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end
          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end
          return "  " .. table.concat(names, ", ")
        end,
        color = { fg = mocha.mauve },
      }

      local location = {
        "location",
        fmt = function()
          local line = vim.fn.line(".")
          local col = vim.fn.col(".")
          local total = vim.fn.line("$")
          return string.format(" %d/%d  %d", line, total, col)
        end,
      }

      local clock = {
        function()
          return os.date(" %H:%M")
        end,
        color = { fg = mocha.sky },
      }

      require("lualine").setup({
        options = {
          theme = "catppuccin",
          section_separators = { left = "", right = "" },
          component_separators = { left = "│", right = "│" },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "alpha", "dashboard" },
            winbar = {},
          },
        },
        sections = {
          lualine_a = { mode_icon },
          lualine_b = {
            { "branch", icon = "", color = { fg = mocha.pink, gui = "bold" } },
            diff,
          },
          lualine_c = { filetype_icon, filename, diagnostics },
          lualine_x = { lsp_info, "encoding" },
          lualine_y = {
            { "progress", color = { fg = mocha.peach } },
          },
          lualine_z = { location, clock },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- BUFFERLINE (beautiful tabs)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.no_italic,
          themable = true,
          numbers = "none",
          close_command = "bdelete!  %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          separator_style = "thin",
          offsets = {
            {
              filetype = "NvimTree",
              text = "  File Explorer",
              text_align = "center",
              highlight = "Directory",
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = false,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          enforce_regular_tabs = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 100,
            reveal = { "close" },
          },
        },
      })
    end,
  },
  -- ══════════════════════════════════════════════════════════════════════
  -- WHICH-KEY (beautiful keybind popups)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("which-key").setup({
        preset = "modern",
        delay = 300,
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = " ",
          ellipsis = "…",
          mappings = true,
          rules = {},
          colors = true,
          keys = {
            Up = " ",
            Down = " ",
            Left = " ",
            Right = " ",
            C = "󰘴 ",
            M = "󰘵 ",
            D = "󰘳 ",
            S = "󰘶 ",
            CR = "󰌑 ",
            Esc = "󱊷 ",
            ScrollWheelDown = "󱕐 ",
            ScrollWheelUp = "󱕑 ",
            NL = "󰌑 ",
            BS = "󰁮",
            Space = "󱁐 ",
            Tab = "󰌒 ",
            F1 = "󱊫",
            F2 = "󱊬",
            F3 = "󱊭",
            F4 = "󱊮",
            F5 = "󱊯",
            F6 = "󱊰",
            F7 = "󱊱",
            F8 = "󱊲",
            F9 = "󱊳",
            F10 = "󱊴",
            F11 = "󱊵",
            F12 = "󱊶",
          },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
          title = true,
          title_pos = "center",
        },
        layout = {
          width = { min = 20, max = 50 },
          spacing = 3,
        },
        spec = {
          { "<leader>b", group = " Buffers" },
          { "<leader>c", group = " Code/Copilot" },
          { "<leader>d", group = " Debug" },
          { "<leader>f", group = " Find (Telescope)" },
          { "<leader>g", group = " Go/Git" },
          { "<leader>n", group = " Neovim Config" },
          { "<leader>r", group = "󰐍 Runner" },
          { "<leader>s", group = " Split/Search" },
          { "<leader>t", group = " Terminal/Tab" },
          { "<leader>u", group = " UI Toggle" },
          { "<leader>x", group = " Diagnostics" },
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- INDENT BLANKLINE (rainbow indent guides)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      -- Rainbow colors
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = mocha.red })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = mocha.yellow })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = mocha.blue })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = mocha.peach })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = mocha.green })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = mocha.mauve })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = mocha.teal })
      end)

      require("ibl").setup({
        indent = {
          char = "│",
          highlight = highlight,
        },
        scope = {
          enabled = true,
          char = "┃",
          highlight = { "RainbowViolet" },
          show_start = true,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "NvimTree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
          },
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- ALPHA (sick dashboard)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      -- Sick ASCII art header
      dashboard.section.header.val = {
        [[                                                                              ]],
        [[  ████████╗ ██████╗ ██████╗  █████╗ ███╗   ██╗████████╗ ██████╗ ██╗   ██╗███████╗]],
        [[  ╚══██╔══╝██╔═══██╗██╔══██╗██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗██║   ██║██╔════╝]],
        [[     ██║   ██║   ██║██████╔╝███████║██╔██╗ ██║   ██║   ██║   ██║██║   ██║███████╗]],
        [[     ██║   ██║   ██║██╔══██╗██╔══██╗██║╚██╗██║   ██║   ██║   ██║██║   ██║╚════██║]],
        [[     ██║   ╚██████╔╝██║  ██║██║  ██║██║ ╚████║   ██║   ╚██████╔╝╚██████╔╝███████║]],
        [[     ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝]],
        [[                                                                              ]],
        [[          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                   ]],
        [[          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                   ]],
        [[          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                   ]],
        [[          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                   ]],
        [[          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                   ]],
        [[          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                   ]],
        [[                                                                              ]],
        [[   ╔══════════════════════════════════════════════════════════════════════╗   ]],
        [[   ║  ⚡ 1 3 3 7 ⚡  │  🔥 T E R M I N A L   A R C H I T E C T 🔥  │  💀  ║   ]],
        [[   ╚══════════════════════════════════════════════════════════════════════╝   ]],
        [[                                                                              ]],
      }

      -- Stylish buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", "  󰈞  Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "    Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", "  󰊄  Live Grep", "<cmd>Telescope live_grep<CR>"),
        dashboard.button("p", "    Projects", "<cmd>Telescope projects<CR>"),
        dashboard.button("e", "    Explorer", "<cmd>NvimTreeToggle<CR>"),
        dashboard.button("c", "    Config", "<cmd>e $MYVIMRC<CR>"),
        dashboard.button("l", "  󰒲  Lazy", "<cmd>Lazy<CR>"),
        dashboard.button("m", "    Mason", "<cmd>Mason<CR>"),
        dashboard.button("q", "    Quit", "<cmd>qa<CR>"),
      }

      -- Style the buttons
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      -- Footer with stats
      dashboard.section.footer.val = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local version = vim.version()
        local nvim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
        return {
          "",
          "⚡ Neovim "
          .. nvim_version
          .. " loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms",
          "",
          "💀 HACK THE PLANET 💀",
        }
      end

      -- Highlights with rainbow gradient per line
      dashboard.section.header.opts.hl = {
        { { "AlphaHeaderRed", 0, -1 } },
        { { "AlphaHeaderPeach", 0, -1 } },
        { { "AlphaHeaderYellow", 0, -1 } },
        { { "AlphaHeaderGreen", 0, -1 } },
        { { "AlphaHeaderSky", 0, -1 } },
        { { "AlphaHeaderBlue", 0, -1 } },
        { { "AlphaHeaderMauve", 0, -1 } },
        { { "AlphaHeaderRed", 0, -1 } },
        { { "AlphaHeaderPeach", 0, -1 } },
        { { "AlphaHeaderYellow", 0, -1 } },
        { { "AlphaHeaderGreen", 0, -1 } },
        { { "AlphaHeaderSky", 0, -1 } },
        { { "AlphaHeaderBlue", 0, -1 } },
        { { "AlphaHeaderMauve", 0, -1 } },
        { { "AlphaHeaderRed", 0, -1 } },
        { { "AlphaHeaderPeach", 0, -1 } },
        { { "AlphaHeaderYellow", 0, -1 } },
        { { "AlphaHeaderGreen", 0, -1 } },
        { { "AlphaHeaderSky", 0, -1 } },
      }
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      -- Custom highlights with rainbow gradient for header
      vim.api.nvim_set_hl(0, "AlphaHeaderRed", { fg = "#f38ba8" })
      vim.api.nvim_set_hl(0, "AlphaHeaderPeach", { fg = "#fab387" })
      vim.api.nvim_set_hl(0, "AlphaHeaderYellow", { fg = "#f9e2af" })
      vim.api.nvim_set_hl(0, "AlphaHeaderGreen", { fg = "#a6e3a1" })
      vim.api.nvim_set_hl(0, "AlphaHeaderSky", { fg = "#89dceb" })
      vim.api.nvim_set_hl(0, "AlphaHeaderBlue", { fg = "#89b4fa" })
      vim.api.nvim_set_hl(0, "AlphaHeaderMauve", { fg = "#cba6f7" })
      vim.api.nvim_set_hl(0, "AlphaButtons", { fg = mocha.text })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = mocha.peach, bold = true })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = mocha.overlay1, italic = true })

      alpha.setup(dashboard.config)

      -- Auto-show alpha on empty buffer
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = {
            "",
            "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            "",
            "💀 HACK THE PLANET 💀",
          }
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- NOICE (fancy cmdline + notifications)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup",
          format = {
            cmdline = { pattern = "^:", icon = " ", lang = "vim" },
            search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
            search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
            filter = { pattern = "^:%s*!", icon = " $", lang = "bash" },
            lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = " ", lang = "lua" },
            help = { pattern = "^:%s*he?l?p?%s+", icon = " 󰋖" },
          },
        },
        messages = {
          enabled = true,
          view = "notify",
          view_error = "notify",
          view_warn = "notify",
          view_history = "messages",
          view_search = "virtualtext",
        },
        popupmenu = {
          enabled = true,
          backend = "nui",
        },
        lsp = {
          progress = {
            enabled = true,
            format = "lsp_progress",
            format_done = "lsp_progress_done",
            throttle = 1000 / 30,
            view = "mini",
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
          hover = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = true,
          lsp_doc_border = true,
        },
        views = {
          cmdline_popup = {
            position = { row = 5, col = "50%" },
            size = { width = 60, height = "auto" },
            border = { style = "rounded", padding = { 0, 1 } },
          },
          popupmenu = {
            relative = "editor",
            position = { row = 8, col = "50%" },
            size = { width = 60, height = 10 },
            border = { style = "rounded", padding = { 0, 1 } },
          },
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- NOTIFY (beautiful notifications)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("notify").setup({
        background_colour = mocha.base,
        fps = 144,
        icons = {
          DEBUG = " ",
          ERROR = " ",
          INFO = " ",
          TRACE = "✎ ",
          WARN = " ",
        },
        level = vim.log.levels.INFO,
        minimum_width = 50,
        max_width = 80,
        render = "wrapped-compact",
        stages = "fade_in_slide_out",
        timeout = 3000,
        top_down = false,
      })

      -- Custom neon glow highlights for notification borders
      vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = mocha.red })
      vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = mocha.green })
      vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = mocha.sky })
      vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = mocha.mauve })

      vim.notify = require("notify")
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- COLORIZER (show hex colors inline)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = false,
          RRGGBBAA = true,
          AARRGGBB = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
          mode = "virtualtext",
          virtualtext = "■",
          always_update = false,
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- TODO COMMENTS (highlight TODOs)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = "󰅒 ", color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = "󰍨 ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        colors = {
          error = { mocha.red },
          warning = { mocha.yellow },
          info = { mocha.blue },
          hint = { mocha.teal },
          default = { mocha.mauve },
          test = { mocha.pink },
        },
        highlight = {
          multiline = true,
          multiline_pattern = "^.",
          multiline_context = 10,
          before = "",
          keyword = "wide",
          after = "fg",
          pattern = [[.*<(KEYWORDS)\s*:]],
          comments_only = true,
          max_line_len = 400,
          exclude = {},
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- MINI ANIMATIONS (smooth scrolling + cursor)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      require("mini.animate").setup({
        cursor = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 80, unit = "total" }),
        },
        scroll = {
          enable = true,
          timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
        },
        resize = { enable = false },
        open = { enable = false },
        close = { enable = false },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- TWILIGHT (dim inactive code)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    config = function()
      require("twilight").setup({
        dimming = { alpha = 0.25, inactive = false },
        context = 10,
        treesitter = true,
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- ZEN MODE (distraction-free)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.95,
          width = 120,
          height = 1,
          options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
            cursorline = false,
          },
        },
        plugins = {
          options = { enabled = true, ruler = false, showcmd = false },
          twilight = { enabled = true },
          gitsigns = { enabled = false },
          tmux = { enabled = false },
        },
      })
    end,
  },

  -- TABBYY (neon VSCode-style tabline, workspace outlines)
  {
    "nanozuki/tabby.nvim",
    event = "VeryLazy",
    config = function()
      require("tabby").setup({
        tabline = require("tabby.presets").active_wins_at_tail,
        theme = {
          fill = "TabLineFill",
          head = { bg = "#cba6f7", fg = "#1e1e2e", bold = true },
          current_tab = { bg = "#313244", fg = "#cdd6f4", italic = true },
          tab = { bg = "#181825", fg = "#bac2de" },
          win = { bg = "#181825", fg = "#bac2de" },
          tail = { bg = "#cba6f7", fg = "#1e1e2e" },
        },
      })
    end,
  },

  -- SMOOTH CURSOR (macchiato neon tail)
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup({
        fancy = {
          enable = true,
          head = { cursor = "▶", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "•", texthl = "SmoothCursorOrange" },
            { cursor = "•", texthl = "SmoothCursorYellow" },
            { cursor = "•", texthl = "SmoothCursorGreen" },
          },
          tail = { cursor = "•", texthl = "SmoothCursorBlue" },
        },
      })
    end,
  },

  -- TOGGLETERM (floating terminals with neon border)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>tt]],
        direction = "float",
        float_opts = { border = "double", winblend = 3 },
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        close_on_exit = true,
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- DROPBAR (VS Code-like breadcrumbs at top)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("dropbar").setup({
        icons = {
          enable = true,
          kinds = {
            symbols = {
              Array = "󰅪 ",
              Boolean = " ",
              BreakStatement = "󰙧 ",
              Call = "󰃷 ",
              CaseStatement = "󱃙 ",
              Class = " ",
              Color = "󰏘 ",
              Constant = "󰏿 ",
              Constructor = " ",
              ContinueStatement = "→ ",
              Copilot = " ",
              Declaration = "󰙠 ",
              Delete = "󰩺 ",
              DoStatement = "󰑖 ",
              Enum = " ",
              EnumMember = " ",
              Event = " ",
              Field = " ",
              File = "󰈔 ",
              Folder = " ",
              ForStatement = "󰑖 ",
              Function = "󰊕 ",
              Identifier = "󰀫 ",
              IfStatement = "󰇉 ",
              Interface = " ",
              Keyword = " ",
              List = "󰅪 ",
              Log = "󰦪 ",
              Lsp = " ",
              Macro = "󰁌 ",
              MarkdownH1 = "󰉫 ",
              MarkdownH2 = "󰉬 ",
              MarkdownH3 = "󰉭 ",
              MarkdownH4 = "󰉮 ",
              MarkdownH5 = "󰉯 ",
              MarkdownH6 = "󰉰 ",
              Method = "󰆧 ",
              Module = "󰏗 ",
              Namespace = " ",
              Null = "󰟢 ",
              Number = "󰎠 ",
              Object = " ",
              Operator = "󰆕 ",
              Package = "󰏗 ",
              Property = " ",
              Reference = " ",
              Regex = " ",
              Repeat = "󰑖 ",
              Scope = " ",
              Snippet = " ",
              Specifier = "󰦪 ",
              Statement = " ",
              String = " ",
              Struct = " ",
              SwitchStatement = "󰺟 ",
              Terminal = " ",
              Text = " ",
              Type = " ",
              TypeParameter = "󰆩 ",
              Unit = " ",
              Value = "󰎠 ",
              Variable = "󰀫 ",
              WhileStatement = "󰑖 ",
            },
          },
          ui = {
            bar = {
              separator = "  ",
              extends = "…",
            },
            menu = {
              separator = " ",
              indicator = " ",
            },
          },
        },
        bar = {
          hover = true,
          sources = function(buf, _)
            local sources = require("dropbar.sources")
            local utils = require("dropbar.utils")
            if vim.bo[buf].ft == "markdown" then
              return { sources.markdown }
            end
            if vim.bo[buf].buftype == "terminal" then
              return { sources.terminal }
            end
            return { sources.path, utils.source.fallback({ sources.lsp, sources.treesitter }) }
          end,
          padding = { left = 1, right = 1 },
        },
      })

      -- Highlights
      vim.api.nvim_set_hl(0, "DropBarIconKindFunction", { fg = mocha.mauve })
      vim.api.nvim_set_hl(0, "DropBarIconKindMethod", { fg = mocha.mauve })
      vim.api.nvim_set_hl(0, "DropBarIconKindClass", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindStruct", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "DropBarIconKindModule", { fg = mocha.blue })
      vim.api.nvim_set_hl(0, "DropBarIconKindFile", { fg = mocha.text })
      vim.api.nvim_set_hl(0, "DropBarIconKindFolder", { fg = mocha.peach })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- HLCHUNK (better code context lines)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "shellRaining/hlchunk.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = {
            { fg = mocha.mauve },
            { fg = mocha.red },
          },
          use_treesitter = true,
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          textobject = "",
          max_file_size = 1024 * 1024,
          error_sign = true,
          animation_easing = "expo",
          duration = 200,
        },
        indent = {
          enable = true,
          style = { { fg = mocha.surface0 } },
          use_treesitter = false,
          chars = { "│" },
        },
        line_num = {
          enable = true,
          style = mocha.mauve,
          use_treesitter = true,
        },
        blank = { enable = false },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- MODES. NVIM (change line color based on mode)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("modes").setup({
        colors = {
          bg = "",
          copy = mocha.yellow,
          delete = mocha.red,
          insert = mocha.green,
          visual = mocha.mauve,
        },
        line_opacity = 0.25,
        set_cursor = true,
        set_cursorline = true,
        set_number = true,
        ignore = { filetypes = { "NvimTree", "TelescopePrompt", "alpha", "neo-tree" } },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- REACTIVE.NVIM (reactive cursor line based on mode)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("reactive").setup({
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = true,
        },
        load = { "catppuccin-mocha-cursor", "catppuccin-mocha-cursorline" },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- NVIM-SCROLLBAR (scrollbar with diagnostics & search)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000,
        max_lines = false,
        hide_if_all_visible = true,
        throttle_ms = 100,
        handle = {
          text = " ",
          blend = 30,
          color = mocha.surface1,
          color_nr = nil,
          highlight = "ScrollbarHandle",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = { text = "•", priority = 0, gui = nil, color = mocha.mauve, cterm = nil, color_nr = nil, highlight = "ScrollbarCursor" },
          Search = { text = { "-", "=" }, priority = 1, gui = nil, color = mocha.peach, cterm = nil, color_nr = nil, highlight = "ScrollbarSearch" },
          Error = { text = { "-", "=" }, priority = 2, gui = nil, color = mocha.red, cterm = nil, color_nr = nil, highlight = "ScrollbarError" },
          Warn = { text = { "-", "=" }, priority = 3, gui = nil, color = mocha.yellow, cterm = nil, color_nr = nil, highlight = "ScrollbarWarn" },
          Info = { text = { "-", "=" }, priority = 4, gui = nil, color = mocha.sky, cterm = nil, color_nr = nil, highlight = "ScrollbarInfo" },
          Hint = { text = { "-", "=" }, priority = 5, gui = nil, color = mocha.teal, cterm = nil, color_nr = nil, highlight = "ScrollbarHint" },
          Misc = { text = { "-", "=" }, priority = 6, gui = nil, color = mocha.mauve, cterm = nil, color_nr = nil, highlight = "ScrollbarMisc" },
          GitAdd = { text = "│", priority = 7, gui = nil, color = mocha.green, cterm = nil, color_nr = nil, highlight = "ScrollbarGitAdd" },
          GitChange = { text = "│", priority = 7, gui = nil, color = mocha.peach, cterm = nil, color_nr = nil, highlight = "ScrollbarGitChange" },
          GitDelete = { text = "▁", priority = 7, gui = nil, color = mocha.red, cterm = nil, color_nr = nil, highlight = "ScrollbarGitDelete" },
        },
        excluded_buftypes = { "terminal" },
        excluded_filetypes = { "alpha", "NvimTree", "lazy", "mason", "TelescopePrompt" },
        autocmd = { render = { "BufWinEnter", "TabEnter", "TermEnter", "WinEnter", "CmdwinLeave", "TextChanged", "VimResized", "WinScrolled" }, clear = { "BufWinLeave", "TabLeave", "TermLeave", "WinLeave" } },
        handlers = { cursor = true, diagnostic = true, gitsigns = true, handle = true, search = false, ale = false },
      })

      -- Gitsigns integration
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- WINDOW-PICKER (pick window with letters)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("window-picker").setup({
        hint = "floating-big-letter",
        selection_chars = "FJDKSLA;CMRUEIWOQP",
        picker_config = {
          statusline_winbar_picker = {
            selection_display = function(char, _)
              return "%=" .. char .. "%="
            end,
            use_winbar = "smart",
          },
          floating_big_letter = {
            font = "ansi-shadow",
          },
        },
        show_prompt = false,
        filter_rules = {
        include_current_win = false,
        autoselect_one = true,
        bo = {
        filetype = { "NvimTree", "neo-tree", "notify", "noice", "alpha" },
        buftype = { "terminal", "quickfix" },
      },
    },
    highlights = {
    statusline = { focused = { fg = mocha.base, bg = mocha.mauve, bold = true }, unfocused = { fg = mocha.base, bg = mocha.surface1 } },
    winbar = { focused = { fg = mocha.base, bg = mocha.mauve, bold = true }, unfocused = { fg = mocha.base, bg = mocha.surface1 } },
  },
})
    end,
  },
  
    -- ══════════════════════════════════════════════════════════════════════
    -- HEADLINES (markdown header highlights)
    -- ══════════════════════════════════════════════════════════════════════
    {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "norg", "org", "rmd" },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      vim.api.nvim_set_hl(0, "Headline1", { fg = mocha.red, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline2", { fg = mocha.peach, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline3", { fg = mocha.yellow, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline4", { fg = mocha.green, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline5", { fg = mocha.blue, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline6", { fg = mocha.mauve, bg = mocha.surface0, bold = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = mocha.mantle })
      vim.api.nvim_set_hl(0, "Dash", { fg = mocha.overlay0, bold = true })
      vim.api.nvim_set_hl(0, "Quote", { fg = mocha.subtext1, italic = true })
      require("headlines").setup({
      markdown = {
      query = vim.treesitter.query.parse("markdown", [[
      (atx_heading [
      (atx_h1_marker)
      (atx_h2_marker)
      (atx_h3_marker)
      (atx_h4_marker)
      (atx_h5_marker)
      (atx_h6_marker)
      ] @headline)
      (thematic_break) @dash
      (fenced_code_block) @codeblock
      (block_quote) @quote
      ]]),
      headline_highlights = { "Headline1", "Headline2", "Headline3", "Headline4", "Headline5", "Headline6" },
      bullet_highlights = { "@text.title.1.marker.markdown", "@text.title.2.marker.markdown", "@text.title.3.marker.markdown", "@text.title.4.marker.markdown", "@text.title.5.marker.markdown", "@text.title.6.marker.markdown" },
      bullets = { "◉", "○", "✸", "✿" },
      codeblock_highlight = "CodeBlock",
      dash_highlight = "Dash",
      dash_string = "─",
      quote_highlight = "Quote",
      quote_string = "┃",
      fat_headlines = true,
      fat_headline_upper_string = "▄",
      fat_headline_lower_string = "▀",
    },
  })
end,
  },
  
  -- ══════════════════════════════════════════════════════════════════════
  -- DRESSING (better vim.ui.input and vim.ui.select)
  -- ══════════════════════════════════════════════════════════════════════
  {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  config = function()
    require("dressing").setup({
    input = {
    enabled = true,
    default_prompt = "➤ ",
    trim_prompt = true,
    title_pos = "center",
    insert_only = true,
    start_in_insert = true,
    border = "rounded",
    relative = "cursor",
    prefer_width = 40,
    width = nil,
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },
    buf_options = {},
    win_options = {
    wrap = false,
    list = true,
    listchars = "precedes:…,extends:…",
    sidescrolloff = 0,
  },
  mappings = {
  n = { ["<Esc>"] = "Close", ["<CR>"] = "Confirm" },
  i = { ["<C-c>"] = "Close", ["<CR>"] = "Confirm", ["<Up>"] = "HistoryPrev", ["<Down>"] = "HistoryNext" },
},
        },
        select = {
        enabled = true,
        backend = { "telescope", "builtin", "nui" },
        trim_prompt = true,
        telescope = nil,
        builtin = {
        show_numbers = true,
        border = "rounded",
        relative = "editor",
        buf_options = {},
        win_options = { cursorline = true, cursorlineopt = "both" },
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },
        mappings = { ["<Esc>"] = "Close", ["<C-c>"] = "Close", ["<CR>"] = "Confirm" },
      },
    },
  })
end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- FIDGET (LSP progress spinner)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("fidget").setup({
        progress = {
          poll_rate = 0,
          suppress_on_insert = true,
          ignore_done_already = false,
          ignore_empty_message = false,
          notification_group = function(msg)
            return msg.lsp_client.name
          end,
          clear_on_detach = function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,
          ignore = {},
          display = {
            render_limit = 16,
            done_ttl = 3,
            done_icon = "✓",
            done_style = "Constant",
            progress_ttl = math.huge,
            progress_icon = { pattern = "dots", period = 1 },
            progress_style = "WarningMsg",
            group_style = "Title",
            icon_style = "Question",
            priority = 30,
            skip_history = true,
            format_message = require("fidget.progress.display").default_format_message,
            format_annote = function(msg)
              return msg.title
            end,
            format_group_name = function(group)
              return tostring(group)
            end,
            overrides = { rust_analyzer = { name = "rust-analyzer" } },
          },
          lsp = {
            progress_ringbuf_size = 0,
            log_handler = false,
          },
        },
        notification = {
          poll_rate = 10,
          filter = vim.log.levels.INFO,
          history_size = 128,
          override_vim_notify = false,
          configs = { default = require("fidget.notification").default_config },
          redirect = function(msg, level, opts)
            if opts and opts.on_open then
              return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
            end
          end,
          view = {
            stack_upwards = true,
            icon_separator = " ",
            group_separator = "---",
            group_separator_hl = "Comment",
            render_message = function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
          },
          window = {
            normal_hl = "Comment",
            winblend = 0,
            border = "none",
            zindex = 45,
            max_width = 0,
            max_height = 0,
            x_padding = 1,
            y_padding = 0,
            align = "bottom",
            relative = "editor",
          },
        },
        integration = {
          ["nvim-tree"] = { enable = true },
          ["xcodebuild-nvim"] = { enable = true },
        },
        logger = {
          level = vim.log.levels.WARN,
          max_size = 10000,
          float_precision = 0.01,
          path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        },
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- ILLUMINATE (highlight same words)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("illuminate").configure({
        providers = { "lsp", "treesitter", "regex" },
        delay = 100,
        filetypes_denylist = { "alpha", "NvimTree", "TelescopePrompt", "lazy", "mason" },
        under_cursor = true,
        large_file_cutoff = nil,
        large_file_overrides = nil,
        min_count_to_highlight = 1,
        should_enable = function(_)
          return true
        end,
        case_insensitive_regex = false,
      })

      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = mocha.surface1 })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = mocha.surface1 })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = mocha.surface1 })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- SMEAR-CURSOR (cursor smear effect)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      use_floating_windows = true,
      legacy_computing_symbols_support = false,
      hide_target_hack = true,
      cursor_color = "#cba6f7",  -- mauve
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.5,
      trailing_exponent = 0,
    },
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- MINI. CURSORWORD (underline word under cursor)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup({ delay = 100 })

      local mocha = require("catppuccin.palettes").get_palette("mocha")
      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true, sp = mocha.mauve })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, sp = mocha.mauve })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- VIRT-COLUMN (colored column line)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "lukas-reineke/virt-column.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("virt-column").setup({
        char = "│",
        virtcolumn = "80,120",
        highlight = "VirtColumn",
      })

      vim.api.nvim_set_hl(0, "VirtColumn", { fg = mocha.surface0 })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- RAINBOW DELIMITERS (rainbow brackets)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = mocha.red })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = mocha.yellow })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = mocha.blue })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = mocha.peach })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = mocha.green })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = mocha.mauve })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = mocha.teal })

      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- GITSIGNS (git decorations) - ENHANCED
  -- ══════════════════════════════════════════════════════════════════════
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signs_staged = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = { follow_files = true },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = "   <author>, <author_time:%R> • <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
          map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
          map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle Blame")
          map("n", "<leader>hd", gs.diffthis, "Diff This")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff This ~")
          map("n", "<leader>td", gs.toggle_deleted, "Toggle Deleted")
        end,
      })
    end,
  },
  -- ══════════════════════════════════════════════════════════════════════
  -- TROUBLE (beautiful diagnostics panel)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
    config = function()
      local mocha = require("catppuccin.palettes").get_palette("mocha")

      require("trouble").setup({
        position = "bottom",
        height = 12,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        group = true,
        padding = true,
        action_keys = {
          close = "q",
          cancel = "<esc>",
          refresh = "r",
          jump = { "<cr>", "<tab>" },
          open_split = { "<c-x>" },
          open_vsplit = { "<c-v>" },
          open_tab = { "<c-t>" },
          jump_close = { "o" },
          toggle_mode = "m",
          toggle_preview = "P",
          hover = "K",
          preview = "p",
          close_folds = { "zM", "zm" },
          open_folds = { "zR", "zr" },
          toggle_fold = { "zA", "za" },
          previous = "k",
          next = "j",
        },
        indent_lines = true,
        auto_open = false,
        auto_close = true,
        auto_preview = true,
        auto_fold = false,
        signs = {
          error = "",
          warning = "",
          hint = "󰌵",
          information = "",
          other = "",
        },
        use_diagnostic_signs = false,
      })
    end,
    keys = {
      { "<leader>xT", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble:  Diagnostics" },
      { "<leader>xt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Trouble: Symbols" },
      { "<leader>xr", "<cmd>Trouble lsp toggle focus=false<cr>", desc = "Trouble: LSP references" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: Quickfix" },
    },
  },
}
