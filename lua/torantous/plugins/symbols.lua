local function kind_icons()
  local ok, lazyvim = pcall(require, "lazyvim.config")
  if ok and lazyvim.icons and lazyvim.icons.kinds then
    return lazyvim.icons.kinds
  end
  return {
    Class = "", Color = "", Constant = "", Constructor = "", Enum = "",
    EnumMember = "", Event = "", Field = "", File = "", Folder = "",
    Function = "󰊕", Interface = "", Keyword = "", Method = "", Module = "",
    Namespace = "", Number = "", Operator = "", Package = "", Property = "",
    Reference = "", Snippet = "", String = "", Struct = "", Text = "",
    TypeParameter = "", Unit = "", Value = "", Variable = "",
  }
end

return {
  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    opts = {
      backends = { "lsp", "treesitter" },
      layout = { min_width = 32 },
      show_guides = true,
      icons = kind_icons(),
      highlight_on_hover = true,
      nerd_font = "auto",
    },
    keys = {
      { "<leader>so", "<cmd>AerialToggle!<cr>", desc = "Symbols outline (Aerial)" },
    },
  },
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = "LspAttach",
    opts = {
      lsp = { auto_attach = true },
      window = {
        border = "rounded",
        size = "80%",
        sections = {
          left = { size = "35%" },
          mid = { size = "30%" },
          right = { size = "35%" },
        },
      },
      icons = kind_icons(),
    },
    keys = {
      { "<leader>sb", function() require("nvim-navbuddy").open() end, desc = "Navbuddy (symbol tree GUI)" },
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      use_diagnostic_signs = true,
      focus = true,
      auto_preview = false,
      modes = {
        lsp_references = { preview = { type = "float", relative = "editor", border = "rounded" } },
        lsp_incoming_calls = {},
        lsp_outgoing_calls = {},
      },
    },
    keys = {
      { "<leader>zb", "<cmd>Trouble lsp_references<cr>", desc = "References (Trouble)" },
      { "<leader>zh", "<cmd>Trouble lsp_incoming_calls<cr>", desc = "Incoming calls" },
      { "<leader>zt", "<cmd>Trouble lsp_outgoing_calls<cr>", desc = "Outgoing calls" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function(_, opts)
      opts = opts or {}
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        layout_config = { height = 0.9, width = 0.9 },
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
        selection_caret = " ",
      })
      return opts
    end,
    keys = {
      { "<leader>zr", "<cmd>Telescope lsp_references<cr>", desc = "References (Telescope)" },
      { "<leader>zz", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
      { "<leader>zi", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
      { "<leader>zs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>zS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
    },
  },
  -- Optional: prettier popups if you don’t already have them
  {
    "folke/noice.nvim",
    optional = true,
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = {
        progress = { enabled = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      views = {
        mini = { border = { style = "rounded" } },
        popupmenu = { border = { style = "rounded" } },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      input = { border = "rounded" },
      select = { backend = { "telescope", "builtin" }, builtin = { border = "rounded" } },
    },
  },
}
