-- Shared color palette (Emacs-Gruv-Vivendi)
local colors = {
  red = "#ee5396",
  green = "#42be65",
  blue = "#3fafff",
  yellow = "#fabd2f",
  peach = "#ff832b",
  mauve = "#ff80ce",
  teal = "#3ddbd9",
  sky = "#82cfff",
  pink = "#ff7eb6",
  text = "#dfdfe0",
  subtext1 = "#bfbfbf",
  overlay0 = "#525252",
  overlay1 = "#6f6f6f",
  surface0 = "#1c1c1c",
  surface1 = "#2a2a2a",
  mantle = "#131313",
  base = "#101010",
  crust = "#000000",
  comment = "#687d68",
  func_blue = "#3fafff",
  keyword = "#ff80ce",
}

return {
  -- ══════════════════════════════════════════════════════════════════════
  -- EMACS HYBRID THEME (native Lua highlight specification)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "emacs-hybrid-theme",
    virtual = true,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"

      -- Clear old highlights
      vim.cmd("highlight clear")
      if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
      end

      local hl = function(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
      end

      -- ── Editor UI ─────────────────────────────────────────────────────
      hl("Normal",       { fg = colors.text,    bg = colors.base })
      hl("NormalNC",     { fg = colors.text,    bg = colors.base })
      hl("NormalFloat",  { fg = colors.text,    bg = colors.base })
      hl("SignColumn",   { fg = colors.overlay0, bg = colors.base })
      hl("EndOfBuffer",  { fg = colors.base,    bg = colors.base })
      hl("CursorLine",   { bg = colors.surface0 })
      hl("CursorLineNr", { fg = colors.yellow,  bg = colors.surface0, bold = true })
      hl("LineNr",       { fg = colors.overlay0 })
      hl("Visual",       { bg = "#2a2a3a" })
      hl("VisualNOS",    { bg = "#2a2a3a" })
      hl("Pmenu",        { fg = colors.text,    bg = colors.mantle })
      hl("PmenuSel",     { fg = colors.base,    bg = colors.blue })
      hl("PmenuSbar",    { bg = colors.surface0 })
      hl("PmenuThumb",   { bg = colors.overlay0 })
      hl("StatusLine",   { fg = colors.text,    bg = colors.mantle })
      hl("StatusLineNC", { fg = colors.overlay1, bg = colors.mantle })
      hl("TabLine",      { fg = colors.overlay1, bg = colors.mantle })
      hl("TabLineFill",  { bg = colors.mantle })
      hl("TabLineSel",   { fg = colors.text,    bg = colors.surface0, bold = true })
      hl("WinSeparator", { fg = colors.surface1 })
      hl("VertSplit",    { fg = colors.surface1 })
      hl("ColorColumn",  { bg = colors.surface0 })
      hl("Folded",       { fg = colors.overlay1, bg = colors.mantle })
      hl("FoldColumn",   { fg = colors.overlay0, bg = colors.base })
      hl("Search",       { fg = colors.base,    bg = colors.yellow })
      hl("IncSearch",    { fg = colors.base,    bg = colors.peach })
      hl("CurSearch",    { fg = colors.base,    bg = colors.peach, bold = true })
      hl("MatchParen",   { fg = colors.yellow,  bold = true, underline = true })
      hl("NonText",      { fg = colors.overlay0 })
      hl("SpecialKey",   { fg = colors.overlay0 })
      hl("Whitespace",   { fg = colors.surface1 })
      hl("Directory",    { fg = colors.blue })
      hl("Title",        { fg = colors.blue,    bold = true })
      hl("ErrorMsg",     { fg = colors.red,     bold = true })
      hl("WarningMsg",   { fg = colors.yellow })
      hl("MoreMsg",      { fg = colors.green })
      hl("ModeMsg",      { fg = colors.text,    bold = true })
      hl("Question",     { fg = colors.green })
      hl("WildMenu",     { fg = colors.base,    bg = colors.yellow })
      hl("Conceal",      { fg = colors.overlay1 })
      hl("SpellBad",     { undercurl = true, sp = colors.red })
      hl("SpellCap",     { undercurl = true, sp = colors.yellow })
      hl("SpellRare",    { undercurl = true, sp = colors.mauve })
      hl("SpellLocal",   { undercurl = true, sp = colors.teal })

      -- ── Syntax Highlights ─────────────────────────────────────────────
      hl("Comment",      { fg = colors.comment, italic = true })
      hl("Constant",     { fg = colors.yellow })
      hl("String",       { fg = colors.yellow })
      hl("Character",    { fg = colors.yellow })
      hl("Number",       { fg = colors.yellow })
      hl("Boolean",      { fg = colors.yellow })
      hl("Float",        { fg = colors.yellow })
      hl("Identifier",   { fg = colors.text })
      hl("Function",     { fg = colors.func_blue })
      hl("Statement",    { fg = colors.keyword })
      hl("Conditional",  { fg = colors.keyword })
      hl("Repeat",       { fg = colors.keyword })
      hl("Label",        { fg = colors.keyword })
      hl("Operator",     { fg = colors.text })
      hl("Keyword",      { fg = colors.keyword })
      hl("Exception",    { fg = colors.keyword })
      hl("PreProc",      { fg = colors.mauve })
      hl("Include",      { fg = colors.keyword })
      hl("Define",       { fg = colors.keyword })
      hl("Macro",        { fg = colors.mauve })
      hl("PreCondit",    { fg = colors.mauve })
      hl("Type",         { fg = colors.teal })
      hl("StorageClass", { fg = colors.keyword })
      hl("Structure",    { fg = colors.teal })
      hl("Typedef",      { fg = colors.teal })
      hl("Special",      { fg = colors.peach })
      hl("SpecialChar",  { fg = colors.peach })
      hl("Tag",          { fg = colors.blue })
      hl("Delimiter",    { fg = colors.text })
      hl("SpecialComment", { fg = colors.comment, italic = true })
      hl("Debug",        { fg = colors.red })
      hl("Underlined",   { underline = true })
      hl("Error",        { fg = colors.red })
      hl("Todo",         { fg = colors.yellow, bg = colors.surface0, bold = true })

      -- ── Treesitter Highlights ─────────────────────────────────────────
      hl("@comment",     { fg = colors.comment, italic = true })
      hl("@string",      { fg = colors.yellow })
      hl("@number",      { fg = colors.yellow })
      hl("@boolean",     { fg = colors.yellow })
      hl("@float",       { fg = colors.yellow })
      hl("@constant",    { fg = colors.yellow })
      hl("@constant.builtin", { fg = colors.yellow })
      hl("@function",    { fg = colors.func_blue })
      hl("@function.call", { fg = colors.func_blue })
      hl("@function.builtin", { fg = colors.func_blue })
      hl("@method",      { fg = colors.func_blue })
      hl("@method.call",  { fg = colors.func_blue })
      hl("@keyword",     { fg = colors.keyword })
      hl("@keyword.function", { fg = colors.keyword })
      hl("@keyword.return", { fg = colors.keyword })
      hl("@keyword.operator", { fg = colors.keyword })
      hl("@conditional", { fg = colors.keyword })
      hl("@repeat",      { fg = colors.keyword })
      hl("@exception",   { fg = colors.keyword })
      hl("@include",     { fg = colors.keyword })
      hl("@type",        { fg = colors.teal })
      hl("@type.builtin", { fg = colors.teal })
      hl("@variable",    { fg = colors.text })
      hl("@variable.builtin", { fg = colors.red })
      hl("@parameter",   { fg = colors.text })
      hl("@field",       { fg = colors.text })
      hl("@property",    { fg = colors.text })
      hl("@operator",    { fg = colors.text })
      hl("@punctuation", { fg = colors.text })
      hl("@punctuation.bracket", { fg = colors.text })
      hl("@punctuation.delimiter", { fg = colors.text })
      hl("@tag",         { fg = colors.blue })
      hl("@tag.attribute", { fg = colors.teal })
      hl("@tag.delimiter", { fg = colors.overlay1 })
      hl("@constructor",  { fg = colors.blue })
      hl("@namespace",    { fg = colors.teal })

      -- ── Diagnostics ───────────────────────────────────────────────────
      hl("DiagnosticError", { fg = colors.red })
      hl("DiagnosticWarn",  { fg = colors.yellow })
      hl("DiagnosticInfo",  { fg = colors.blue })
      hl("DiagnosticHint",  { fg = colors.teal })
      hl("DiagnosticUnderlineError", { undercurl = true, sp = colors.red })
      hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = colors.yellow })
      hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = colors.blue })
      hl("DiagnosticUnderlineHint",  { undercurl = true, sp = colors.teal })

      -- ── Diff ──────────────────────────────────────────────────────────
      hl("DiffAdd",    { bg = "#1a2e1a" })
      hl("DiffChange", { bg = "#1a1a2e" })
      hl("DiffDelete", { fg = colors.red, bg = "#2e1a1a" })
      hl("DiffText",   { bg = "#2a2a4a" })

      -- ── Float / Border ────────────────────────────────────────────────
      hl("FloatBorder", { fg = colors.overlay0, bg = colors.base })
      hl("FloatTitle",  { fg = colors.yellow,   bg = colors.base, bold = true })

      -- ── Telescope (borders blend with background) ─────────────────────
      hl("TelescopeBorder",        { fg = colors.base, bg = colors.base })
      hl("TelescopePreviewBorder", { fg = colors.base, bg = colors.base })
      hl("TelescopePromptBorder",  { fg = colors.base, bg = colors.base })
      hl("TelescopeResultsBorder", { fg = colors.base, bg = colors.base })
      hl("TelescopePromptTitle",   { fg = colors.base, bg = colors.yellow, bold = true })
      hl("TelescopeResultsTitle",  { fg = colors.base, bg = colors.blue, bold = true })
      hl("TelescopePreviewTitle",  { fg = colors.base, bg = colors.green, bold = true })
      hl("TelescopePromptNormal",  { fg = colors.text, bg = colors.base })
      hl("TelescopeResultsNormal", { fg = colors.text, bg = colors.base })
      hl("TelescopePreviewNormal", { fg = colors.text, bg = colors.base })

      -- ── Git Signs ─────────────────────────────────────────────────────
      hl("GitSignsAdd",    { fg = colors.green })
      hl("GitSignsChange", { fg = colors.blue })
      hl("GitSignsDelete", { fg = colors.red })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- LUALINE (bare metal statusline)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
        colored = true,
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
      }

      -- Custom lualine theme using the Emacs-Gruv-Vivendi palette
      local emacs_hybrid_lualine = {
        normal = {
          a = { fg = colors.base, bg = colors.yellow, gui = "bold" },
          b = { fg = colors.text, bg = colors.surface1 },
          c = { fg = colors.text, bg = colors.mantle },
        },
        insert = {
          a = { fg = colors.base, bg = colors.green, gui = "bold" },
        },
        visual = {
          a = { fg = colors.base, bg = colors.mauve, gui = "bold" },
        },
        replace = {
          a = { fg = colors.base, bg = colors.red, gui = "bold" },
        },
        command = {
          a = { fg = colors.base, bg = colors.blue, gui = "bold" },
        },
        inactive = {
          a = { fg = colors.overlay1, bg = colors.mantle },
          b = { fg = colors.overlay1, bg = colors.mantle },
          c = { fg = colors.overlay1, bg = colors.mantle },
        },
      }

      require("lualine").setup({
        options = {
          theme = emacs_hybrid_lualine,
          section_separators = { left = "", right = "" },
          component_separators = { left = "│", right = "│" },
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "alpha", "dashboard" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = { filename, diagnostics },
          lualine_x = { lsp_info },
          lualine_y = {},
          lualine_z = { "location" },
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()

      require("bufferline").setup({
        options = {
          mode = "buffers",
          style_preset = require("bufferline").style_preset.no_italic,
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
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
          border = "single",
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
  -- INDENT BLANKLINE (simple indent guides)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
        },
        scope = {
          enabled = false,
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
      vim.api.nvim_set_hl(0, "AlphaButtons", { fg = colors.text })
      vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = colors.peach, bold = true })
      vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.overlay1, italic = true })

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
            border = { style = "single", padding = { 0, 1 } },
          },
          popupmenu = {
            relative = "editor",
            position = { row = 8, col = "50%" },
            size = { width = 60, height = 10 },
            border = { style = "single", padding = { 0, 1 } },
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

      require("notify").setup({
        background_colour = colors.base,
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
      vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors.red })
      vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors.green })
      vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors.sky })
      vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = colors.mauve })

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
          error = { colors.red },
          warning = { colors.yellow },
          info = { colors.blue },
          hint = { colors.teal },
          default = { colors.mauve },
          test = { colors.pink },
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

  -- TOGGLETERM (floating terminals with neon border)
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<leader>tt]],
        direction = "float",
        float_opts = { border = "single", winblend = 3 },
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
  -- HLCHUNK (better code context lines)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "shellRaining/hlchunk.nvim",
    event = "VeryLazy",
    config = function()

      require("hlchunk").setup({
        chunk = {
          enable = true,
          style = {
            { fg = colors.mauve },
            { fg = colors.red },
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
          style = { { fg = colors.surface0 } },
          use_treesitter = false,
          chars = { "│" },
        },
        line_num = {
          enable = true,
          style = colors.mauve,
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

      require("modes").setup({
        colors = {
          bg = "",
          copy = colors.yellow,
          delete = colors.red,
          insert = colors.green,
          visual = colors.mauve,
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

      require("reactive").setup({
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = true,
        },
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
          color = colors.surface1,
          color_nr = nil,
          highlight = "ScrollbarHandle",
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = { text = "•", priority = 0, gui = nil, color = colors.mauve, cterm = nil, color_nr = nil, highlight = "ScrollbarCursor" },
          Search = { text = { "-", "=" }, priority = 1, gui = nil, color = colors.peach, cterm = nil, color_nr = nil, highlight = "ScrollbarSearch" },
          Error = { text = { "-", "=" }, priority = 2, gui = nil, color = colors.red, cterm = nil, color_nr = nil, highlight = "ScrollbarError" },
          Warn = { text = { "-", "=" }, priority = 3, gui = nil, color = colors.yellow, cterm = nil, color_nr = nil, highlight = "ScrollbarWarn" },
          Info = { text = { "-", "=" }, priority = 4, gui = nil, color = colors.sky, cterm = nil, color_nr = nil, highlight = "ScrollbarInfo" },
          Hint = { text = { "-", "=" }, priority = 5, gui = nil, color = colors.teal, cterm = nil, color_nr = nil, highlight = "ScrollbarHint" },
          Misc = { text = { "-", "=" }, priority = 6, gui = nil, color = colors.mauve, cterm = nil, color_nr = nil, highlight = "ScrollbarMisc" },
          GitAdd = { text = "│", priority = 7, gui = nil, color = colors.green, cterm = nil, color_nr = nil, highlight = "ScrollbarGitAdd" },
          GitChange = { text = "│", priority = 7, gui = nil, color = colors.peach, cterm = nil, color_nr = nil, highlight = "ScrollbarGitChange" },
          GitDelete = { text = "▁", priority = 7, gui = nil, color = colors.red, cterm = nil, color_nr = nil, highlight = "ScrollbarGitDelete" },
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
    statusline = { focused = { fg = colors.base, bg = colors.mauve, bold = true }, unfocused = { fg = colors.base, bg = colors.surface1 } },
    winbar = { focused = { fg = colors.base, bg = colors.mauve, bold = true }, unfocused = { fg = colors.base, bg = colors.surface1 } },
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
      vim.api.nvim_set_hl(0, "Headline1", { fg = colors.red, bg = colors.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline2", { fg = colors.peach, bg = colors.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline3", { fg = colors.yellow, bg = colors.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline4", { fg = colors.green, bg = colors.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline5", { fg = colors.blue, bg = colors.surface0, bold = true })
      vim.api.nvim_set_hl(0, "Headline6", { fg = colors.mauve, bg = colors.surface0, bold = true })
      vim.api.nvim_set_hl(0, "CodeBlock", { bg = colors.mantle })
      vim.api.nvim_set_hl(0, "Dash", { fg = colors.overlay0, bold = true })
      vim.api.nvim_set_hl(0, "Quote", { fg = colors.subtext1, italic = true })
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
    border = "single",
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
        border = "single",
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

      vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = colors.surface1 })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = colors.surface1 })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = colors.surface1 })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- MINI. CURSORWORD (underline word under cursor)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup({ delay = 100 })

      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true, sp = colors.mauve })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, sp = colors.mauve })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- RAINBOW DELIMITERS (rainbow brackets)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()

      vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = colors.red })
      vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = colors.yellow })
      vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = colors.peach })
      vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = colors.green })
      vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = colors.mauve })
      vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = colors.teal })

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
          border = "single",
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
  -- NOTE: trouble.nvim is configured in symbols.lua with v3 API and keymaps
}
