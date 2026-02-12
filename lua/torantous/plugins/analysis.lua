-- ============================================================================
--  ██████╗ ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗
--  ██╔══██╗██║████╗  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
--  ██████╔╝██║██╔██╗ ██║███████║██████╔╝ ╚████╔╝
--  ██╔══██╗██║██║╚██╗██║██╔══██║██╔══██╗  ╚██╔╝
--  ██████╔╝██║██║ ╚████║██║  ██║██║  ██║   ██║
--  ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝
--  BINARY ANALYSIS // Hex, Disassembly, ELF/PE Headers, Black Ops Suite
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

  -- ══════════════════════════════════════════════════════════════════════
  -- BLACK OPS SUITE
  -- Macro X-Ray, Strings Extractor, Entropy Analysis, Binary Diff,
  -- YARA Scanner, Syscall Tracer
  -- ══════════════════════════════════════════════════════════════════════
  {
    "nvim-lua/plenary.nvim",
    name = "blackops",
    keys = {
      { "<leader>am", desc = "Macro X-Ray: expand macros" },
      { "<leader>am", mode = "v", desc = "Macro X-Ray: expand selection" },
      { "<leader>as", desc = "Strings: extract printable strings" },
      { "<leader>aE", desc = "Entropy: byte entropy analysis" },
      { "<leader>aD", desc = "BinDiff: compare two binaries" },
      { "<leader>ay", desc = "YARA: scan with rules" },
      { "<leader>aT", desc = "Syscall: trace system calls" },
    },
    config = function()
      local scratch_dir = vim.fn.isdirectory("/dev/shm") == 1 and "/dev/shm" or "/tmp"

      --- Helper: open data lines in a scratch vsplit with a given filetype.
      local function open_scratch_split(data, title, ft)
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].modifiable = false
        vim.cmd("vsplit")
        vim.api.nvim_win_set_buf(0, buf)
        if ft then
          vim.bo[buf].filetype = ft
        end
        vim.api.nvim_buf_set_name(buf, title)
      end

      -- ════════════════════════════════════════════════════════════
      -- 1. MACRO X-RAY (Visual Pre-processor)
      -- Runs gcc/clang -E to expand macros and shows the result in
      -- a vsplit. Works on the whole buffer or a visual selection.
      -- ════════════════════════════════════════════════════════════

      --- Expand macros for the given line range (1-indexed, inclusive).
      local function macro_expand(line1, line2)
        local file = vim.fn.expand("%:p")
        local ft = vim.bo.filetype

        if ft ~= "c" and ft ~= "cpp" then
          vim.notify("MacroExpand: only C/C++ files supported", vim.log.levels.ERROR)
          return
        end

        local preprocessor = ft == "cpp" and "g++ -std=c++23 -E" or "gcc -E"
        local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
        local tmp_in = scratch_dir .. "/macro_xray_" .. os.time() .. (ft == "cpp" and ".cpp" or ".c")

        -- Collect #include lines from the top of the buffer for context
        local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local includes = {}
        for _, l in ipairs(all_lines) do
          if l:match("^%s*#%s*include") then
            table.insert(includes, l)
          end
        end

        local f = io.open(tmp_in, "w")
        if not f then
          vim.notify("MacroExpand: cannot write temp file", vim.log.levels.ERROR)
          return
        end
        for _, inc in ipairs(includes) do
          f:write(inc .. "\n")
        end
        for _, l in ipairs(lines) do
          f:write(l .. "\n")
        end
        f:close()

        local cmd = preprocessor .. " " .. vim.fn.shellescape(tmp_in) .. " 2>/dev/null"

        vim.notify("MacroExpand: preprocessing...", vim.log.levels.INFO)
        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          on_stdout = function(_, data)
            if data then
              vim.schedule(function()
                -- Filter out # line directives for cleaner output
                local result = {}
                for _, l in ipairs(data) do
                  if not l:match("^#%s+%d+") then
                    table.insert(result, l)
                  end
                end
                open_scratch_split(result, "[Macro X-Ray]", ft)
                vim.notify("MacroExpand: done", vim.log.levels.INFO)
                os.remove(tmp_in)
              end)
            end
          end,
          on_exit = function(_, code)
            if code ~= 0 then
              vim.schedule(function()
                vim.notify("MacroExpand: preprocessor failed (exit " .. code .. ")", vim.log.levels.ERROR)
                os.remove(tmp_in)
              end)
            end
          end,
        })
      end

      vim.api.nvim_create_user_command("MacroExpand", function(opts)
        macro_expand(opts.line1, opts.line2)
      end, { range = "%", desc = "Expand C/C++ macros (preprocessor -E)" })

      -- ════════════════════════════════════════════════════════════
      -- 2. BINARY STRINGS EXTRACTOR
      -- Runs `strings` on a binary file and shows results in a vsplit.
      -- Supports configurable minimum string length.
      -- ════════════════════════════════════════════════════════════

      vim.api.nvim_create_user_command("Strings", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })
        local min_len = "4"
        local target = vim.fn.expand("%:p")

        for i, arg in ipairs(args) do
          if arg:match("^-n") then
            min_len = arg:sub(3)
            if min_len == "" and args[i + 1] then
              min_len = args[i + 1]
            end
          elseif arg ~= "" then
            target = arg
          end
        end

        local cmd = "strings -n " .. vim.fn.shellescape(min_len) .. " " .. vim.fn.shellescape(target)

        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data then
              vim.schedule(function()
                open_scratch_split(data, "[Strings: " .. vim.fn.fnamemodify(target, ":t") .. "]", nil)
              end)
            end
          end,
          on_stderr = function(_, data)
            if data and data[1] ~= "" then
              vim.schedule(function()
                vim.notify("Strings: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
              end)
            end
          end,
        })
      end, { nargs = "?", complete = "file", desc = "Extract printable strings from binary (strings -n)" })

      -- ════════════════════════════════════════════════════════════
      -- 3. ENTROPY ANALYSIS
      -- Calculates Shannon entropy per 256-byte block and shows
      -- a visual report. High entropy = likely packed/encrypted.
      -- Pure Lua implementation, no external tools needed.
      -- ════════════════════════════════════════════════════════════

      vim.api.nvim_create_user_command("Entropy", function(opts)
        local target = opts.args ~= "" and opts.args or vim.fn.expand("%:p")

        local f = io.open(target, "rb")
        if not f then
          vim.notify("Entropy: cannot open file", vim.log.levels.ERROR)
          return
        end
        local content = f:read("*a")
        f:close()

        if #content == 0 then
          vim.notify("Entropy: file is empty", vim.log.levels.WARN)
          return
        end

        local block_size = 256
        local result = {
          "┌─────────────────────────────────────────────────────────┐",
          "│  Entropy Analysis: " .. vim.fn.fnamemodify(target, ":t"),
          "│  File size: " .. #content .. " bytes",
          "│  Block size: " .. block_size .. " bytes",
          "├─────────────────────────────────────────────────────────┤",
          "│  Offset      Entropy   Bar                    Status",
          "├─────────────────────────────────────────────────────────┤",
        }

        -- Calculate per-block entropy
        local total_entropy = 0
        local num_blocks = 0
        local high_blocks = 0

        for offset = 1, #content, block_size do
          local block = content:sub(offset, offset + block_size - 1)
          local counts = {}
          for i = 1, #block do
            local byte = block:byte(i)
            counts[byte] = (counts[byte] or 0) + 1
          end

          local entropy = 0
          local len = #block
          for _, count in pairs(counts) do
            local p = count / len
            if p > 0 then
              entropy = entropy - p * math.log(p) / math.log(2)
            end
          end

          total_entropy = total_entropy + entropy
          num_blocks = num_blocks + 1

          -- Visual bar (max entropy = 8 bits)
          local bar_len = math.floor(entropy / 8 * 20)
          local bar = string.rep("█", bar_len) .. string.rep("░", 20 - bar_len)

          local status = ""
          if entropy > 7.5 then
            status = "⚠ PACKED/ENCRYPTED"
            high_blocks = high_blocks + 1
          elseif entropy > 6.0 then
            status = "~ compressed"
          elseif entropy < 1.0 then
            status = "○ sparse/null"
          end

          table.insert(result, string.format(
            "│  0x%08X  %.4f    %s  %s",
            offset - 1, entropy, bar, status
          ))
        end

        local avg_entropy = num_blocks > 0 and total_entropy / num_blocks or 0
        table.insert(result, "├─────────────────────────────────────────────────────────┤")
        table.insert(result, string.format("│  Average entropy: %.4f / 8.0000", avg_entropy))
        table.insert(result, string.format("│  High-entropy blocks: %d / %d", high_blocks, num_blocks))
        if avg_entropy > 7.0 then
          table.insert(result, "│  ⚠  VERDICT: Likely packed, encrypted, or compressed")
        elseif avg_entropy > 5.0 then
          table.insert(result, "│  ~  VERDICT: Mixed content (code + data)")
        else
          table.insert(result, "│  ✓  VERDICT: Normal uncompressed binary/text")
        end
        table.insert(result, "└─────────────────────────────────────────────────────────┘")

        open_scratch_split(result, "[Entropy: " .. vim.fn.fnamemodify(target, ":t") .. "]", nil)
      end, { nargs = "?", complete = "file", desc = "Byte entropy analysis (detect packed/encrypted sections)" })

      -- ════════════════════════════════════════════════════════════
      -- 4. BINARY DIFF
      -- Side-by-side hex comparison of two files using xxd + diff.
      -- Opens a diff-mode view highlighting byte-level changes.
      -- ════════════════════════════════════════════════════════════

      vim.api.nvim_create_user_command("BinDiff", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })
        if #args ~= 2 then
          vim.notify("BinDiff: requires exactly two file arguments", vim.log.levels.ERROR)
          return
        end

        local file_a = vim.fn.expand(args[1])
        local file_b = vim.fn.expand(args[2])

        if vim.fn.filereadable(file_a) ~= 1 then
          vim.notify("BinDiff: cannot read " .. file_a, vim.log.levels.ERROR)
          return
        end
        if vim.fn.filereadable(file_b) ~= 1 then
          vim.notify("BinDiff: cannot read " .. file_b, vim.log.levels.ERROR)
          return
        end

        local hex_a = scratch_dir .. "/bindiff_a_" .. os.time() .. ".hex"
        local hex_b = scratch_dir .. "/bindiff_b_" .. os.time() .. ".hex"

        -- Generate hex dumps, then open in diff mode
        local cmd = "xxd " .. vim.fn.shellescape(file_a) .. " > " .. vim.fn.shellescape(hex_a)
            .. " && xxd " .. vim.fn.shellescape(file_b) .. " > " .. vim.fn.shellescape(hex_b)
        -- NOTE: hex_a/hex_b are safe paths constructed from scratch_dir + os.time(),
        -- and shellescape protects them in the redirection targets.

        vim.fn.jobstart(cmd, {
          on_exit = function(_, code)
            vim.schedule(function()
              if code ~= 0 then
                vim.notify("BinDiff: xxd failed (exit " .. code .. ")", vim.log.levels.ERROR)
                return
              end
              vim.cmd("edit " .. vim.fn.fnameescape(hex_a))
              vim.bo.bufhidden = "wipe"
              vim.bo.filetype = "xxd"
              vim.cmd("diffthis")
              vim.cmd("vsplit " .. vim.fn.fnameescape(hex_b))
              vim.bo.bufhidden = "wipe"
              vim.bo.filetype = "xxd"
              vim.cmd("diffthis")
              vim.notify("BinDiff: showing differences", vim.log.levels.INFO)
            end)
          end,
        })
      end, { nargs = "+", complete = "file", desc = "Side-by-side hex diff of two binary files" })

      -- ════════════════════════════════════════════════════════════
      -- 5. YARA RULE SCANNER
      -- Scans files with YARA rules for malware pattern matching.
      -- Usage: :YaraScan <rules_file> [target_file]
      -- ════════════════════════════════════════════════════════════

      vim.api.nvim_create_user_command("YaraScan", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })
        if #args < 1 then
          vim.notify("YaraScan: requires at least a YARA rules file\nUsage: :YaraScan <rules.yar> [target]", vim.log.levels.ERROR)
          return
        end

        local rules_file = vim.fn.expand(args[1])
        local target = #args >= 2 and vim.fn.expand(args[2]) or vim.fn.expand("%:p")

        if vim.fn.filereadable(rules_file) ~= 1 then
          vim.notify("YaraScan: rules file not found: " .. rules_file, vim.log.levels.ERROR)
          return
        end
        if vim.fn.filereadable(target) ~= 1 then
          vim.notify("YaraScan: target file not found: " .. target, vim.log.levels.ERROR)
          return
        end

        if vim.fn.executable("yara") ~= 1 then
          vim.notify("YaraScan: yara not found in PATH (install: apt install yara)", vim.log.levels.ERROR)
          return
        end

        local cmd = "yara -s " .. vim.fn.shellescape(rules_file) .. " " .. vim.fn.shellescape(target)

        vim.notify("YaraScan: scanning...", vim.log.levels.INFO)
        vim.fn.jobstart(cmd, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            if data then
              vim.schedule(function()
                if #data == 1 and data[1] == "" then
                  vim.notify("YaraScan: no matches found", vim.log.levels.INFO)
                  return
                end
                local result = {
                  "┌─────────────────────────────────────────────────────────┐",
                  "│  YARA Scan Results",
                  "│  Rules: " .. vim.fn.fnamemodify(rules_file, ":t"),
                  "│  Target: " .. vim.fn.fnamemodify(target, ":t"),
                  "├─────────────────────────────────────────────────────────┤",
                }
                for _, line in ipairs(data) do
                  if line ~= "" then
                    table.insert(result, "│  " .. line)
                  end
                end
                table.insert(result, "└─────────────────────────────────────────────────────────┘")
                open_scratch_split(result, "[YARA: " .. vim.fn.fnamemodify(target, ":t") .. "]", nil)
              end)
            end
          end,
          on_stderr = function(_, data)
            if data and data[1] ~= "" then
              vim.schedule(function()
                vim.notify("YaraScan: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
              end)
            end
          end,
        })
      end, { nargs = "+", complete = "file", desc = "Scan file with YARA rules for malware signatures" })

      -- ════════════════════════════════════════════════════════════
      -- 6. SYSCALL TRACER
      -- Compiles (if needed) and runs the current file under strace
      -- to trace system calls. Output shown in a vsplit.
      -- ════════════════════════════════════════════════════════════

      vim.api.nvim_create_user_command("SyscallTrace", function(opts)
        local file = vim.fn.expand("%:p")
        local ft = vim.bo.filetype
        local base = vim.fn.expand("%:t:r")
        local dir = vim.fn.expand("%:p:h")
        local trace_out = scratch_dir .. "/" .. base .. "_strace_" .. os.time() .. ".log"

        -- Build map for compiled languages
        local build_cmds = {
          cpp = "g++ -std=c++23 -g " .. vim.fn.shellescape(file) .. " -o " .. vim.fn.shellescape(dir .. "/" .. base),
          c = "gcc -g " .. vim.fn.shellescape(file) .. " -o " .. vim.fn.shellescape(dir .. "/" .. base),
          rust = "rustc -g " .. vim.fn.shellescape(file) .. " -o " .. vim.fn.shellescape(dir .. "/" .. base),
        }

        -- Run map (what to strace)
        local lua_cmd = vim.fn.executable("luajit") == 1 and "luajit" or "lua"
        local run_cmds = {
          cpp = vim.fn.shellescape(dir .. "/" .. base),
          c = vim.fn.shellescape(dir .. "/" .. base),
          rust = vim.fn.shellescape(dir .. "/" .. base),
          go = "go run " .. vim.fn.shellescape(file),
          python = "python3 " .. vim.fn.shellescape(file),
          lua = lua_cmd .. " " .. vim.fn.shellescape(file),
          sh = "bash " .. vim.fn.shellescape(file),
          bash = "bash " .. vim.fn.shellescape(file),
        }

        if vim.fn.executable("strace") ~= 1 then
          vim.notify("SyscallTrace: strace not found in PATH (install: apt install strace)", vim.log.levels.ERROR)
          return
        end

        local run_target = run_cmds[ft]
        if not run_target then
          vim.notify("SyscallTrace: unsupported filetype: " .. ft, vim.log.levels.ERROR)
          return
        end

        -- Extra strace args from command input
        local strace_args = opts.args ~= "" and (" " .. opts.args) or ""

        local strace_cmd = "strace -f -o " .. vim.fn.shellescape(trace_out) .. strace_args .. " " .. run_target
        local full_cmd = strace_cmd

        -- If compiled language, build first
        local build_cmd = build_cmds[ft]
        if build_cmd then
          full_cmd = build_cmd .. " && " .. strace_cmd
        end

        vim.notify("SyscallTrace: tracing...", vim.log.levels.INFO)
        vim.fn.jobstart(full_cmd, {
          cwd = dir,
          on_exit = function(_, code)
            vim.schedule(function()
              if vim.fn.filereadable(trace_out) ~= 1 then
                vim.notify("SyscallTrace: no output produced (exit " .. code .. ")", vim.log.levels.ERROR)
                return
              end
              vim.cmd("vsplit " .. vim.fn.fnameescape(trace_out))
              vim.bo.bufhidden = "wipe"
              vim.bo.filetype = "strace"
              vim.notify("SyscallTrace: done (" .. vim.fn.getfsize(trace_out) .. " bytes)", vim.log.levels.INFO)
            end)
          end,
        })
      end, { nargs = "?", desc = "Trace system calls with strace" })

      -- ── Black Ops Keymaps ──
      vim.keymap.set("n", "<leader>am", "<cmd>MacroExpand<cr>", { desc = "Macro X-Ray: expand macros" })
      vim.keymap.set("v", "<leader>am", ":MacroExpand<cr>", { desc = "Macro X-Ray: expand selection" })
      vim.keymap.set("n", "<leader>as", "<cmd>Strings<cr>", { desc = "Strings: extract printable strings" })
      vim.keymap.set("n", "<leader>aE", "<cmd>Entropy<cr>", { desc = "Entropy: byte entropy analysis" })
      vim.keymap.set("n", "<leader>aD", ":BinDiff ", { desc = "BinDiff: compare two binaries" })
      vim.keymap.set("n", "<leader>ay", ":YaraScan ", { desc = "YARA: scan with rules" })
      vim.keymap.set("n", "<leader>aT", "<cmd>SyscallTrace<cr>", { desc = "Syscall: trace system calls" })
    end,
  },
}
