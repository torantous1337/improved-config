-- ============================================================================
--  ██████╗ ██╗   ██╗███╗   ██╗███╗   ██╗███████╗██████╗
--  ██╔══██╗██║   ██║████╗  ██║████╗  ██║██╔════╝██╔══██╗
--  ██████╔╝██║   ██║██╔██╗ ██║██╔██╗ ██║█████╗  ██████╔╝
--  ██╔══██╗██║   ██║██║╚██╗██║██║╚██╗██║██╔══╝  ██╔══██╗
--  ██║  ██║╚██████╔╝██║ ╚████║██║ ╚████║███████╗██║  ██║
--  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝
--  TORANTOUS CODE RUNNER // Build & Run Any Language
-- ============================================================================
--
--  FEATURES:
--  ─────────────────────────────────────────────────────────────────────────
--  • Auto-detects filetype and runs appropriate build/run commands
--  • Support for:  C, C++, Python, Lua, Go, Rust, Assembly, Java, JS/TS, Bash
--  • Interactive argument input with history
--  • Multiple run modes: Run, Build, Build & Run, Test
--  • Floating window output with syntax highlighting
--  • Configurable per-project and per-filetype settings
--  • Remembers last used arguments per file
--  • Quick repeat last command
--
--  KEYMAPS (default <leader>r prefix):
--  ─────────────────────────────────────────────────────────────────────────
--  <leader>rr  │ Run current file (with last args)
--  <leader>ra  │ Run with arguments (prompt)
--  <leader>rb  │ Build only (compile)
--  <leader>rx  │ Build and run
--  <leader>rt  │ Run tests
--  <leader>rs  │ Stop running process
--  <leader>rc  │ Clear output window
--  <leader>ro  │ Toggle output window
--  <leader>ri  │ Show file/language info
--  <leader>rl  │ Repeat last command
--  <F6>        │ Quick run (no args)
--  <F7>        │ Run with args
--
--  PLACEHOLDERS:
--  ─────────────────────────────────────────────────────────────────────────
--  %f  │ Full file path
--  %b  │ File basename (without extension)
--  %d  │ File directory
--  %e  │ File extension
--  %a  │ User arguments
--  %p  │ Project root directory
--
-- ============================================================================

-- Runner module (not a lazy plugin, just config)
local Runner = {}

-- ════════════════════════════════════════════════════════════════
-- CONFIGURATION
-- ════════════════════════════════════════════════════════════════

Runner.config = {
  commands = {
    -- C++
    cpp = {
      icon = "",
      name = "C++",
      -- Removed manual quotes (') because shellescape adds them safely
      build = "g++ -Wall -Wextra -std=c++17 -g %f -o %b",
      run = "./%b %a",
      build_run = "g++ -Wall -Wextra -std=c++17 -g %f -o %b && ./%b %a",
    },
    -- C
    c = {
      icon = "",
      name = "C",
      build = "gcc -Wall -Wextra -g %f -o %b",
      run = "./%b %a",
      build_run = "gcc -Wall -Wextra -g %f -o %b && ./%b %a",
    },
    -- Python
    python = {
      icon = "",
      name = "Python",
      run = "python3 -u %f %a",
      test = "python3 -m pytest %f %a",
    },
    -- Lua
    -- Lua (all variants)
    lua = {
      icon = "",
      name = "Lua",
      run = "luajit %f %a",           -- Default:  LuaJIT (faster)
      lua51 = "lua5.1 %f %a",         -- Lua 5.1
      lua54 = "lua5.4 %f %a",         -- Lua 5.4
      luajit = "luajit %f %a",        -- LuaJIT explicit
      jit_opt = "luajit -O3 %f %a",   -- LuaJIT max optimization
      jit_debug = "luajit -jv %f %a", -- LuaJIT with JIT trace info
      nvim = "luafile %f",              -- Run in Neovim
      love = "love %d %a",            -- Love2D
    },
    
      lapis = {
        icon = "󰖟",
        name = "Lapis",
        run = "lapis server",
        test = "busted",
      },

      -- Busted (Lua testing)
      busted = {
        icon = "󰙨",
        name = "Busted",
        run = "busted %f %a",
        test = "busted",
      },

      -- Moonscript (compiles to Lua)
      moonscript = {
        icon = "🌙",
        name = "MoonScript",
        build = "moonc %f",
        run = "moon %f %a",
        build_run = "moonc %f && lua %b.lua %a",
      },
      -- Love2D (detected by main.lua in directory)
      love2d = {
        icon = "❤",
        name = "Love2D",
        run = "love %d %a",
        build = "love %d --fused %a",
        debug = "love %d --console %a",
      },
      -- Go (enhanced)
      go = {
        icon = "",
        name = "Go",
        run = "go run %f %a",
        run_pkg = "go run . %a",
        build = "go build -o %b %f",
        build_pkg = "go build .",
        build_run = "go build -o %b %f && ./%b %a",
        test = "go test -v ./...",
        test_file = "go test -v %f",
        test_cover = "go test -v -cover ./...",
        bench = "go test -bench=. -benchmem ./...",
        lint = "golangci-lint run",
        vet = "go vet ./...",
        fmt = "gofmt -w %f",
        mod_tidy = "go mod tidy",
        mod_download = "go mod download",
      },  -- Rust
      rust = {
        icon = "",
        name = "Rust",
        build = "rustc %f -o %b",
        run = "%b %a",
        build_run = "rustc %f -o %b && %b %a",
        cargo_run = "cargo run %a",
        cargo_build = "cargo build",
        test = "cargo test %a",
      },
      -- Assembly (NASM x86_64 Linux)
      asm = {
        icon = "",
        name = "Assembly",
        build = "nasm -f elf64 %f -o %b.o && ld %b.o -o %b",
        run = "%b %a",
        build_run = "nasm -f elf64 %f -o %b.o && ld %b.o -o %b && %b %a",
      },
      -- Java
      java = {
        icon = "",
        name = "Java",
        build = "javac %f",
        run = "java -cp %d %b %a",
        build_run = "javac %f && java -cp %d %b %a",
      },
      -- JavaScript (Node)
      javascript = {
        icon = "",
        name = "JavaScript",
        run = "node %f %a",
        test = "npm test %a",
      },
      -- TypeScript
      typescript = {
        icon = "",
        name = "TypeScript",
        run = "npx ts-node %f %a",
        build = "npx tsc %f",
      },
      -- Bash/Shell
      sh = {
        icon = "",
        name = "Shell",
        run = "bash %f %a",
      },
      bash = {
        icon = "",
        name = "Bash",
        run = "bash %f %a",
      },
      -- Ruby
      ruby = {
        icon = "",
        name = "Ruby",
        run = "ruby %f %a",
      },
      -- PHP
      php = {
        icon = "",
        name = "PHP",
        run = "php %f %a",
      },
      -- Makefile
      make = {
        icon = "",
        name = "Make",
        build = "make -C %d",
        run = "make -C %d run",
        clean = "make -C %d clean",
      },
    },

    ui = {
      border = "rounded",
      width = 0.8,
      height = 0.6,
    },

    behavior = {
      save_before_run = true,
      auto_scroll = true,
      clear_before_run = true,
      notify_on_complete = true,
      remember_args = true,
    },
  }

  -- ════════════════════════════════════════════════════════════════
  -- STATE
  -- ════════════════════════════════════════════════════════════════

  Runner.state = {
    output_buf = nil,
    output_win = nil,
    job_id = nil,
    last_cmd = nil,
    args_history = {},
    is_running = false,
  }

  -- ════════════════════════════════════════════════════════════════
  -- UTILITIES
  -- ════════════════════════════════════════════════════════════════
  local function get_file_info()
    return {
      path = vim.fn.expand("%:p"),
      name = vim.fn.expand("%:t"),           -- main. cpp
      base = vim.fn.expand("%:t:r"),         -- main (just filename, no path, no extension)
      ext = vim.fn.expand("%:e"),            -- cpp
      dir = vim.fn.expand("%:p:h"),          -- /home/mario/Desktop/cpp-project
      ft = vim.bo.filetype,
    }
  end
  -- Detect if this is a Love2D project
  local function detect_love2d()
    local dir = vim.fn.expand("%:p:h")
    -- Check if main.lua exists and contains love callbacks
    local main_path = dir .. "/main.lua"
    if vim.fn.filereadable(main_path) == 1 then
      local content = vim.fn.readfile(main_path)
      for _, line in ipairs(content) do
        if line:match("love%. ") then
          return true
        end
      end
    end
    -- Also check for conf.lua
    if vim.fn.filereadable(dir .. "/conf.lua") == 1 then
      return true
    end
    return false
  end
  -- Detect if file needs LuaJIT (uses FFI)
  local function detect_luajit()
    local file_path = vim.fn.expand("%:p")
    if vim.fn.filereadable(file_path) == 0 then return false end

    -- Read first 50 lines to save performance
    local content = vim.fn.readfile(file_path, "", 50)
    for _, line in ipairs(content) do
      -- Check for require("ffi") or require 'ffi'
      if line:match("require%s*%(?['\"]ffi['\"]%)?") then
        return true
      end
    end
    return false
  end
  local function find_project_root()
    local markers = { ".git", "Makefile", "Cargo.toml", "go.mod", "package.json", ".runner.lua" }
    local path = vim.fn.expand("%:p:h")

    while path ~= "/" do
      for _, marker in ipairs(markers) do
        if vim.fn.isdirectory(path .. "/" .. marker) == 1 or vim.fn.filereadable(path .. "/" .. marker) == 1 then
          return path
        end
      end
      path = vim.fn.fnamemodify(path, ":h")
    end

    return vim.fn.expand("%:p:h")
  end

  local function replace_placeholders(cmd, file_info, args)
    local project_root = find_project_root()

    -- SECURE FIX: Use vim.fn.shellescape to prevent command injection via filenames
    cmd = cmd:gsub("%%f", vim.fn.shellescape(file_info.path))
    cmd = cmd:gsub("%%b", vim.fn.shellescape(file_info.base))
    cmd = cmd:gsub("%%d", vim.fn.shellescape(file_info.dir))
    cmd = cmd:gsub("%%e", vim.fn.shellescape(file_info.ext))
    cmd = cmd:gsub("%%p", vim.fn.shellescape(project_root))
    
    -- NOTE: Arguments (%a) are NOT shell escaped to allow passing multiple flags/arguments.
    -- Be careful when running commands with untrusted arguments.
    cmd = cmd:gsub("%%a", args or "")
    
    cmd = cmd:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

    return cmd
  end

  local function load_project_config()
    local root = find_project_root()
    local config_path = root .. "/.runner.lua"

    if vim.fn.filereadable(config_path) == 1 then
      local ok, config = pcall(dofile, config_path)
      if ok and type(config) == "table" then
        return config
      end
    end
    return nil
  end

  local function get_filetype_config(ft)
    local project_config = load_project_config()

    if project_config and project_config[ft] then
      return vim.tbl_deep_extend("force", Runner.config.commands[ft] or {}, project_config[ft])
    end

    return Runner.config.commands[ft]
  end

  -- ════════════════════════════════════════════════════════════════
  -- OUTPUT WINDOW
  -- ════════════════════════════════════════════════════════════════

  local function create_output_window()
    local ui = Runner.config.ui
    local width = math.floor(vim.o.columns * ui.width)
    local height = math.floor(vim.o.lines * ui.height)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    if not Runner.state.output_buf or not vim.api.nvim_buf_is_valid(Runner.state.output_buf) then
      Runner.state.output_buf = vim.api.nvim_create_buf(false, true)
      vim.bo[Runner.state.output_buf].buftype = "nofile"
      vim.bo[Runner.state.output_buf].bufhidden = "hide"
      vim.bo[Runner.state.output_buf].swapfile = false
    end

    Runner.state.output_win = vim.api.nvim_open_win(Runner.state.output_buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = ui.border,
      title = " 󰐍 Code Runner ",
      title_pos = "center",
    })

    vim.wo[Runner.state.output_win].wrap = true
    vim.wo[Runner.state.output_win].cursorline = true

    -- Output window keymaps
    local buf = Runner.state.output_buf
    vim.keymap.set("n", "q", function() Runner.close_output() end, { buffer = buf, desc = "Close" })
    vim.keymap.set("n", "<Esc>", function() Runner.close_output() end, { buffer = buf, desc = "Close" })
    vim.keymap.set("n", "r", function() Runner.repeat_last() end, { buffer = buf, desc = "Repeat" })
    vim.keymap.set("n", "c", function() Runner.clear_output() end, { buffer = buf, desc = "Clear" })
    vim.keymap.set("n", "s", function() Runner.stop() end, { buffer = buf, desc = "Stop" })
  end

  local function ensure_output_window()
    if not Runner.state.output_win or not vim.api.nvim_win_is_valid(Runner.state.output_win) then
      create_output_window()
    end
  end

  local function append_output(lines)
    if not Runner.state.output_buf or not vim.api.nvim_buf_is_valid(Runner.state.output_buf) then
      return
    end

    vim.schedule(function()
      local buf = Runner.state.output_buf
      vim.bo[buf].modifiable = true

      local line_count = vim.api.nvim_buf_line_count(buf)
      if line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "" then
        vim.api.nvim_buf_set_lines(buf, 0, 1, false, lines)
      else
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, lines)
      end

      vim.bo[buf].modifiable = false

      -- Auto-scroll
      if Runner.config.behavior.auto_scroll and Runner.state.output_win and vim.api.nvim_win_is_valid(Runner.state.output_win) then
        local new_count = vim.api.nvim_buf_line_count(buf)
        vim.api.nvim_win_set_cursor(Runner.state.output_win, { new_count, 0 })
      end
    end)
  end

  -- ════════════════════════════════════════════════════════════════
  -- RUNNER CORE
  -- ════════════════════════════════════════════════════════════════

  function Runner.run(mode, args)
    local file_info = get_file_info()
    local ft = file_info.ft
    if ft == "lua" and detect_love2d() then
      ft = "love2d"
    elseif ft == "lua" and mode == "run" then
      if detect_luajit() then
        -- Switch mode to 'jit' defined in step 1
        mode = "jit"
        -- Optional: Change name for the header UI
        Runner.config.commands.lua.name = "LuaJIT"
      else
        -- Reset name back to Lua (in case it was changed previously)
        Runner.config.commands.lua.name = "Lua"
      end
    end

    local ft_config = get_filetype_config(ft) 
    if not ft_config then
      vim.notify("  No runner for: " .. file_info.ft, vim.log.levels.ERROR)
      return
    end

    local cmd_template = ft_config[mode]
    if not cmd_template then
      -- Fallback:  try "run" mode
      cmd_template = ft_config["run"]
      mode = "run"
    end

    if not cmd_template then
      vim.notify("  No '" .. mode .. "' command for " .. file_info.ft, vim.log.levels.ERROR)
      return
    end

    -- Auto-save
    if Runner.config.behavior.save_before_run and vim.bo.modified then
      vim.cmd("silent write")
    end

    -- Remember args
    if args == nil and Runner.config.behavior.remember_args then
      args = Runner.state.args_history[file_info.path] or ""
    end
    if args and args ~= "" then
      Runner.state.args_history[file_info.path] = args
    end

    local cmd = replace_placeholders(cmd_template, file_info, args or "")

    Runner.state.last_cmd = cmd
    Runner.state.last_file = file_info.path

    ensure_output_window()

    if Runner.config.behavior.clear_before_run then
      Runner.clear_output()
    end

    -- Header
    local icon = ft_config.icon or "󰐍"
    local header = {
      "┌─────────────────────────────────────────────────────────────┐",
      "│ " .. icon .. "  " .. (ft_config.name or file_info.ft) .. "  │ " .. mode: upper(),
      "├─────────────────────────────────────────────────────────────┤",
      "│ File: " .. file_info.name ..  "                             │", 
      "│ Cmd:   " .. cmd:sub(1, 55),   "                             │ ",
      "└─────────────────────────────────────────────────────────────┘",
      "",
    }
    append_output(header)

    -- Run
    Runner.state.is_running = true
    local start_time = vim.uv.now()

    Runner.state.job_id = vim.fn.jobstart(cmd, {
      cwd = file_info.dir,
      on_stdout = function(_, data)
        if data then append_output(data) end
      end,
      on_stderr = function(_, data)
        if data then append_output(data) end
      end,
      on_exit = function(_, exit_code)
        Runner.state.is_running = false
        local elapsed = (vim.uv.now() - start_time) / 1000

        local status_icon = exit_code == 0 and "✓" or "✗"
        local footer = {
          "",
          "─────────────────────────────────────────────────────────────",
          string.format(" %s Exit:  %d │ Time: %.2fs", status_icon, exit_code, elapsed),
        }
        append_output(footer)

        if Runner.config.behavior.notify_on_complete then
          local msg = exit_code == 0 and "  Success" or "  Failed (exit " .. exit_code .. ")"
          local level = exit_code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
          vim.schedule(function()
            vim.notify(msg .. string.format(" (%.2fs)", elapsed), level)
          end)
        end
      end,
    })
  end

  function Runner.run_with_args()
    local file_info = get_file_info()
    local last_args = Runner.state.args_history[file_info.path] or ""

    vim.ui.input({
      prompt = "  Arguments: ",
      default = last_args,
    }, function(input)
      if input ~= nil then
        Runner.run("run", input)
      end
    end)
  end

  function Runner.build()
    Runner.run("build", "")
  end

  function Runner.build_run()
    Runner.run("build_run", nil)
  end

  function Runner.test()
    Runner.run("test", nil)
  end

  function Runner.stop()
    if Runner.state.job_id then
      vim.fn.jobstop(Runner.state.job_id)
      Runner.state.is_running = false
      append_output({ "", " ⏹ Process stopped", "" })
      vim.notify(" ⏹ Stopped", vim.log.levels.WARN)
    end
  end

  function Runner.repeat_last()
    if Runner.state.last_cmd then
      ensure_output_window()
      if Runner.config.behavior.clear_before_run then
        Runner.clear_output()
      end
      append_output({ " Repeating.. .", "", "$ " .. Runner.state.last_cmd, "" })

      Runner.state.is_running = true
      Runner.state.job_id = vim.fn.jobstart(Runner.state.last_cmd, {
        on_stdout = function(_, data) if data then append_output(data) end end,
        on_stderr = function(_, data) if data then append_output(data) end end,
        on_exit = function(_, code)
          Runner.state.is_running = false
          append_output({ "", " Exit: " .. code })
        end,
      })
    else
      vim.notify("  No command to repeat", vim.log.levels.WARN)
    end
  end

  function Runner.clear_output()
    if Runner.state.output_buf and vim.api.nvim_buf_is_valid(Runner.state.output_buf) then
      vim.bo[Runner.state.output_buf].modifiable = true
      vim.api.nvim_buf_set_lines(Runner.state.output_buf, 0, -1, false, {})
      vim.bo[Runner.state.output_buf].modifiable = false
    end
  end

  function Runner.close_output()
    if Runner.state.output_win and vim.api.nvim_win_is_valid(Runner.state.output_win) then
      vim.api.nvim_win_close(Runner.state.output_win, true)
      Runner.state.output_win = nil
    end
  end

  function Runner.toggle_output()
    if Runner.state.output_win and vim.api.nvim_win_is_valid(Runner.state.output_win) then
      Runner.close_output()
    else
      ensure_output_window()
    end
  end

  function Runner.show_info()
    local file_info = get_file_info()
    local ft_config = get_filetype_config(file_info.ft)

    local lines = { "󰐍 Runner Info", "", " File: " .. file_info.name, " Type: " .. file_info.ft, "" }

    if ft_config then
      table.insert(lines, " Commands:")
      for mode, cmd in pairs(ft_config) do
        if type(cmd) == "string" then
          table.insert(lines, "   " .. mode .. ": " .. cmd:sub(1, 45))
        end
      end
    else
      table.insert(lines, "  No config for this filetype")
    end

    vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
  end

  function Runner.pick_mode()
    local file_info = get_file_info()
    local ft_config = get_filetype_config(file_info.ft)

    if not ft_config then
      vim.notify("  No runner for: " .. file_info.ft, vim.log.levels.ERROR)
      return
    end

    local modes = {}
    for mode, cmd in pairs(ft_config) do
      if type(cmd) == "string" then
        table.insert(modes, { mode = mode, cmd = cmd })
      end
    end

    vim.ui.select(modes, {
      prompt = "  Select mode:",
      format_item = function(item)
        return " " .. item.mode .. " │ " .. item.cmd:sub(1, 40)
      end,
    }, function(choice)
      if choice then
        Runner.run(choice.mode, nil)
      end
    end)
  end

  -- ════════════════════════════════════════════════════════════════
  -- SETUP KEYMAPS
  -- ════════════════════════════════════════════════════════════════

  local map = vim.keymap.set

  map("n", "<leader>rr", function() Runner.run("run", nil) end, { desc = "Run file" })
  map("n", "<leader>ra", function() Runner.run_with_args() end, { desc = "Run with args" })
  map("n", "<leader>rb", function() Runner.build() end, { desc = "Build" })
  map("n", "<leader>rx", function() Runner.build_run() end, { desc = "Build & Run" })
  map("n", "<leader>rt", function() Runner.test() end, { desc = "Run tests" })
  map("n", "<leader>rs", function() Runner.stop() end, { desc = "Stop" })
  map("n", "<leader>rc", function() Runner.clear_output() end, { desc = "Clear output" })
  map("n", "<leader>ro", function() Runner.toggle_output() end, { desc = "Toggle output" })
  map("n", "<leader>rl", function() Runner.repeat_last() end, { desc = "Repeat last" })
  map("n", "<leader>ri", function() Runner.show_info() end, { desc = "Runner info" })
  map("n", "<leader>rp", function() Runner.pick_mode() end, { desc = "Pick mode" })

  map("n", "<F6>", function() Runner.run("run", nil) end, { desc = "Quick run" })
  map("n", "<F7>", function() Runner.run_with_args() end, { desc = "Run with args" })

  -- Global access
  _G.Runner = Runner
  return {}
