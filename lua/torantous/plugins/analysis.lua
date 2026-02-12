-- ============================================================================
--  ██████╗ ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗
--  ██╔══██╗██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
--  ██████╔╝██║██╔██╗ ██║███████║██████╔╝ ╚████╔╝
--  ██╔══██╗██║██║╚██╗██║██╔══██║██╔══██╗  ╚██╔╝
--  ██████╔╝██║██║ ╚████║██║  ██║██║  ██║   ██║
--  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝
--  BINARY ANALYSIS // Hex, Disassembly, ELF/PE Headers
-- ============================================================================

return {
  -- ══════════════════════════════════════════════════════════════════════
  -- HEX.NVIM (hex editor for binary files)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "RaafatTurki/hex.nvim",
    cmd = { "HexDump", "HexAssemble", "HexToggle" },
    keys = {
      { "<leader>ah", "<cmd>HexToggle<cr>", desc = "Toggle hex view" },
    },
    config = function()
      require("hex").setup()
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- GODBOLT.NVIM (compiler explorer - live disassembly)
  -- ══════════════════════════════════════════════════════════════════════
  {
    "p00f/godbolt.nvim",
    cmd = { "Godbolt", "GodboltCompiler" },
    keys = {
      { "<leader>ag", "<cmd>Godbolt<cr>", desc = "Godbolt: compile & show asm" },
      { "<leader>ag", "<cmd>GodboltCompiler<cr>", mode = "v", desc = "Godbolt: compile selection" },
    },
    config = function()
      require("godbolt").setup({
        languages = {
          cpp = { compiler = "g132", options = {} },
          c = { compiler = "cg132", options = {} },
          rust = { compiler = "r1800", options = {} },
        },
        quickfix = {
          enable = true,
          auto_open = true,
        },
        url = "https://godbolt.org",
      })
    end,
  },

  -- ══════════════════════════════════════════════════════════════════════
  -- LOCAL DISASSEMBLY & HEADER INSPECTION COMMANDS
  -- ══════════════════════════════════════════════════════════════════════
  {
    "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>ad", desc = "Disassemble current buffer" },
      { "<leader>ae", desc = "Inspect ELF headers" },
      { "<leader>ap", desc = "Inspect PE headers" },
    },
    config = function()
      -- ── :Disasm command ──
      -- Compiles the current C/C++ buffer with -S and displays the
      -- assembly output in a vertical split.
      vim.api.nvim_create_user_command("Disasm", function()
        local file = vim.fn.expand("%:p")
        local ft = vim.bo.filetype
        local base = vim.fn.expand("%:t:r")
        local scratch_dir = vim.fn.isdirectory("/dev/shm") == 1 and "/dev/shm" or "/tmp"
        local asm_out = scratch_dir .. "/" .. base .. ".s"

        local compilers = {
          cpp = "g++ -std=c++23 -O2 -S -masm=intel -fno-asynchronous-unwind-tables",
          c = "gcc -O2 -S -masm=intel -fno-asynchronous-unwind-tables",
          rust = "rustc --emit asm -C opt-level=2 -C llvm-args=-x86-asm-syntax=intel",
        }

        local compiler = compilers[ft]
        if not compiler then
          vim.notify("Disasm: unsupported filetype: " .. ft, vim.log.levels.ERROR)
          return
        end

        local cmd = compiler .. " " .. vim.fn.shellescape(file) .. " -o " .. vim.fn.shellescape(asm_out)

        vim.notify("Disasm: compiling...", vim.log.levels.INFO)
        vim.fn.jobstart(cmd, {
          on_exit = function(_, code)
            vim.schedule(function()
              if code ~= 0 then
                vim.notify("Disasm: compilation failed (exit " .. code .. ")", vim.log.levels.ERROR)
                return
              end
              vim.cmd("vsplit " .. vim.fn.fnameescape(asm_out))
              vim.bo.filetype = "asm"
              vim.bo.bufhidden = "wipe"
              vim.notify("Disasm: done", vim.log.levels.INFO)
            end)
          end,
        })
      end, { desc = "Compile current buffer and show assembly in vsplit" })

      -- ── :ElfHeaders command ──
      -- Inspects ELF headers of the given file (or compiled current buffer).
      vim.api.nvim_create_user_command("ElfHeaders", function(opts)
        local target = opts.args ~= "" and opts.args or vim.fn.expand("%:p")
        local cmd = "readelf -h -l -S " .. vim.fn.shellescape(target)

        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data then
              vim.schedule(function()
                local buf = vim.api.nvim_create_buf(false, true)
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
                vim.bo[buf].buftype = "nofile"
                vim.bo[buf].bufhidden = "wipe"
                vim.bo[buf].modifiable = false
                vim.cmd("vsplit")
                vim.api.nvim_win_set_buf(0, buf)
                vim.bo[buf].filetype = "elf"
              end)
            end
          end,
          on_stderr = function(_, data)
            if data and data[1] ~= "" then
              vim.schedule(function()
                vim.notify("ElfHeaders: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
              end)
            end
          end,
        })
      end, { nargs = "?", complete = "file", desc = "Inspect ELF headers (readelf)" })

      -- ── :PeHeaders command ──
      -- Inspects PE headers using objdump (for cross-compiled Windows binaries).
      vim.api.nvim_create_user_command("PeHeaders", function(opts)
        local target = opts.args ~= "" and opts.args or vim.fn.expand("%:p")
        local cmd = "objdump -x " .. vim.fn.shellescape(target)

        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data then
              vim.schedule(function()
                local buf = vim.api.nvim_create_buf(false, true)
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
                vim.bo[buf].buftype = "nofile"
                vim.bo[buf].bufhidden = "wipe"
                vim.bo[buf].modifiable = false
                vim.cmd("vsplit")
                vim.api.nvim_win_set_buf(0, buf)
              end)
            end
          end,
          on_stderr = function(_, data)
            if data and data[1] ~= "" then
              vim.schedule(function()
                vim.notify("PeHeaders: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
              end)
            end
          end,
        })
      end, { nargs = "?", complete = "file", desc = "Inspect PE headers (objdump -x)" })

      -- Keymaps
      vim.keymap.set("n", "<leader>ad", "<cmd>Disasm<cr>", { desc = "Disassemble current buffer" })
      vim.keymap.set("n", "<leader>ae", "<cmd>ElfHeaders<cr>", { desc = "Inspect ELF headers" })
      vim.keymap.set("n", "<leader>ap", "<cmd>PeHeaders<cr>", { desc = "Inspect PE headers" })
    end,
  },
}
