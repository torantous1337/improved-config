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
--  • Multi-process support (one job per buffer)
--  • Scratchpad support (run unsaved buffers via /tmp)
--  • Environment variable parsing from args (VAR=VAL prefix)
--  • Hex dump output mode (pipe through xxd / hexdump -C)
--  • Smart CMake detection (auto-uses cmake if CMakeLists.txt found)
--  • Red Team modes: cross-compile, DLL, shellcode, objdump
--  • Interactive terminal mode (termopen + startinsert for stdin programs)
--  • Smart output highlighting (Error/Warning/Success + filetype detection)
--  • DAP debug adapter handoff (auto-config for C++/Rust/Go/Python)
--  • Watch mode (auto-run on BufWritePost)
--
--  KEYMAPS (default <leader>r prefix):
--  ─────────────────────────────────────────────────────────────────────────
--  <leader>rr  │ Run current file (with last args)
--  <leader>ra  │ Run with arguments (prompt)
--  <leader>rb  │ Build only (compile)
--  <leader>rx  │ Build and run
--  <leader>rt  │ Run tests
--  <leader>rs  │ Stop running process (current buffer)
--  <leader>rS  │ Stop ALL running processes
--  <leader>rc  │ Clear output window
--  <leader>ro  │ Toggle output window
--  <leader>ri  │ Show file/language info
--  <leader>rl  │ Repeat last command
--  <leader>rp  │ Pick mode (select from all available modes)
--  <leader>rh  │ Run with hex dump output
--  <leader>rn  │ Run interactive (terminal mode with stdin)
--  <leader>rd  │ Debug via DAP (nvim-dap handoff)
--  <leader>rw  │ Toggle watch mode (auto-run on save)
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
--  %P  │ Project root directory basename (folder name)
--
-- ============================================================================

-- Runner module (standalone, no external plugin dependencies)
local Runner = {}

-- ════════════════════════════════════════════════════════════════
-- CONFIGURATION
-- ════════════════════════════════════════════════════════════════

Runner.config = {
	commands = {
		-- ──────────────────────────────────────────────────────────
		-- C++ (Default: Clang 18+, C++23)
		-- ──────────────────────────────────────────────────────────
		cpp = {
			icon = "",
			name = "C++",

			-- UPDATED: Added "-stdlib=libc++" to build, run, and build_run
			build = "clang++ -stdlib=libc++ -Wall -Wextra -std=c++23 -g %a %f -o %b",
			run = "clang++ -stdlib=libc++ -Wall -Wextra -std=c++23 -g %f -o %b && ./%b %a",
			build_run = "clang++ -stdlib=libc++ -Wall -Wextra -std=c++23 -g %f -o %b && ./%b %a",

			-- Keep the rest (cpp20, gpp_build, etc.) exactly as they were...
			cpp20 = "clang++ -stdlib=libc++ -Wall -Wextra -std=c++20 -g %a %f -o %b && ./%b %a",

			-- (Alternate G++ and Win32 sections remain unchanged)
			gpp_build = "g++ -Wall -Wextra -std=c++23 -g %a %f -o %b",
			gpp_build_run = "g++ -Wall -Wextra -std=c++23 -g %f -o %b && ./%b %a",
			win32 = "x86_64-w64-mingw32-g++ -static %a %f -o %b.exe",
			dll = "x86_64-w64-mingw32-g++ -shared -static %a %f -o %b.dll",
			win32_x86 = "i686-w64-mingw32-g++ -static %a %f -o %b_x86.exe",
			asm_dump = "g++ -g -c %f -o %b.o && objdump -d -M intel -S %b.o",
		},

		-- ──────────────────────────────────────────────────────────
		-- C (Default: Clang, Alternate: GCC)
		-- ──────────────────────────────────────────────────────────
		c = {
			icon = "",
			name = "C",

			build = "clang -Wall -Wextra -g %a %f -o %b",
			run = "clang -Wall -Wextra -g %f -o %b && ./%b %a", -- compile-on-run
			build_run = "clang -Wall -Wextra -g %f -o %b && ./%b %a",

			gcc_build = "gcc -Wall -Wextra -g %a %f -o %b",
			gcc_build_run = "gcc -Wall -Wextra -g %f -o %b && ./%b %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Python
		-- ──────────────────────────────────────────────────────────
		python = {
			icon = "",
			name = "Python",
			run = "python3 -u %f %a",
			test = "python3 -m pytest %f %a",
			serve = "python3 -m http.server 8000",
		},

		-- ──────────────────────────────────────────────────────────
		-- CMake (Auto-detected when CMakeLists.txt is in project root)
		-- ──────────────────────────────────────────────────────────
		cmake = {
			icon = "",
			name = "CMake",
			build = "cmake -B build -S %p -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cmake --build build %a",
			run = "cmake -B build -S %p && cmake --build build && ./build/%P %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Lua (all variants)
		-- ──────────────────────────────────────────────────────────
		lua = {
			icon = "",
			name = "Lua",
			run = "luajit %f %a",
			lua51 = "lua5.1 %f %a",
			lua54 = "lua5.4 %f %a",
			luajit = "luajit %f %a",
			jit_opt = "luajit -O3 %f %a",
			jit_debug = "luajit -jv %f %a",
			nvim = "luafile %f",
			love = "love %d %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Lapis (OpenResty web framework for Lua)
		-- ──────────────────────────────────────────────────────────
		lapis = {
			icon = "󰖟",
			name = "Lapis",
			run = "lapis server %a",
			test = "busted %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Busted (Lua testing)
		-- ──────────────────────────────────────────────────────────
		busted = {
			icon = "󰙨",
			name = "Busted",
			run = "busted %f %a",
			test = "busted %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- MoonScript (compiles to Lua)
		-- ──────────────────────────────────────────────────────────
		moonscript = {
			icon = "🌙",
			name = "MoonScript",
			build = "moonc %f %a",
			run = "moon %f %a",
			build_run = "moonc %f && lua %b.lua %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Love2D (detected by main.lua / conf.lua in directory)
		-- ──────────────────────────────────────────────────────────
		love2d = {
			icon = "❤",
			name = "Love2D",
			run = "love %d %a",
			build = "love %d --fused %a",
			debug = "love %d --console %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Go (enhanced)
		-- ──────────────────────────────────────────────────────────
		go = {
			icon = "",
			name = "Go",
			run = "go run %f %a", -- compile-on-run (go handles it)
			run_pkg = "go run . %a",
			build = "go build -o %b %f %a",
			build_pkg = "go build . %a",
			build_run = "go build -o %b %f && ./%b %a", -- compile-on-run
			test = "go test -v ./... %a",
			test_file = "go test -v %f %a",
			test_cover = "go test -v -cover ./... %a",
			bench = "go test -bench=. -benchmem ./... %a",
			lint = "golangci-lint run %a",
			vet = "go vet ./... %a",
			fmt = "gofmt -w %f",
			mod_tidy = "go mod tidy",
			mod_download = "go mod download",

			-- ── RED TEAM: Windows Cross-Compile (64-bit) ──
			win_build = "GOOS=windows GOARCH=amd64 go build -o %b.exe %f %a",
			-- ── RED TEAM: Windows Cross-Compile (32-bit) ──
			win32_build = "GOOS=windows GOARCH=386 go build -o %b_x86.exe %f %a",
			-- ── RED TEAM: Build as C-Shared DLL ──
			-- Export functions via `//export FuncName` comments in Go source.
			dll_build = "GOOS=windows GOARCH=amd64 go build -buildmode=c-shared -o %b.dll %f %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Rust
		-- ──────────────────────────────────────────────────────────
		rust = {
			icon = "",
			name = "Rust",
			build = "rustc %f -o %b %a",
			run = "rustc %f -o %b && ./%b %a", -- compile-on-run
			build_run = "rustc %f -o %b && ./%b %a",
			cargo_run = "cargo run %a",
			cargo_build = "cargo build %a",
			test = "cargo test %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Assembly (NASM x86_64 Linux)
		-- ──────────────────────────────────────────────────────────
		asm = {
			icon = "",
			name = "Assembly",
			build = "nasm -f elf64 %f -o %b.o && ld %b.o -o %b %a",
			run = "nasm -f elf64 %f -o %b.o && ld %b.o -o %b && ./%b %a", -- compile-on-run
			build_run = "nasm -f elf64 %f -o %b.o && ld %b.o -o %b && ./%b %a",

			-- ── RED TEAM: Raw Flat Binary (Shellcode) ──
			-- Produces position-independent flat binary for injection payloads.
			-- Use with: xxd -i %b.bin to get a C byte array, or load directly into RWX memory.
			asm_bin = "nasm -f bin %f -o %b.bin %a",

			-- ── RED TEAM: Windows Object File (link with MSVC / MinGW on target) ──
			win_obj = "nasm -f win64 %f -o %b.obj %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Java
		-- ──────────────────────────────────────────────────────────
		java = {
			icon = "",
			name = "Java",
			build = "javac %f %a",
			run = "javac %f && java -cp %d %b %a", -- compile-on-run
			build_run = "javac %f && java -cp %d %b %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- JavaScript (Node)
		-- ──────────────────────────────────────────────────────────
		javascript = {
			icon = "",
			name = "JavaScript",
			run = "node %f %a",
			test = "npm test %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- TypeScript
		-- ──────────────────────────────────────────────────────────
		typescript = {
			icon = "",
			name = "TypeScript",
			run = "npx ts-node %f %a",
			build = "npx tsc %f %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Bash / Shell
		-- ──────────────────────────────────────────────────────────
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

		-- ──────────────────────────────────────────────────────────
		-- Ruby
		-- ──────────────────────────────────────────────────────────
		ruby = {
			icon = "",
			name = "Ruby",
			run = "ruby %f %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- PHP
		-- ──────────────────────────────────────────────────────────
		php = {
			icon = "",
			name = "PHP",
			run = "php %f %a",
		},

		-- ──────────────────────────────────────────────────────────
		-- Makefile
		-- ──────────────────────────────────────────────────────────
		make = {
			icon = "",
			name = "Make",
			build = "make -C %d %a",
			run = "make -C %d run %a",
			clean = "make -C %d clean %a",
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
		interactive = false, -- if true, default run uses termopen (for stdin)
	},
}

-- ════════════════════════════════════════════════════════════════
-- STATE
-- Multi-process: each buffer can have its own running job.
-- ════════════════════════════════════════════════════════════════

Runner.state = {
	output_buf = nil,
	output_win = nil,
	term_buf = nil, -- dedicated terminal buffer (termopen creates its own)
	term_win = nil, -- floating window for interactive terminal
	jobs = {}, -- keyed by bufnr → job_id (multi-process support)
	last_cmd = nil,
	last_cwd = nil,
	last_env = nil,
	last_mode = nil, -- last mode string for highlight decisions
	args_history = {}, -- keyed by filepath → last args string
	is_running = false, -- true if ANY job is active (for UI hints)
	watch = {}, -- keyed by bufnr → autocmd id (watch mode)
	hl_ns = vim.api.nvim_create_namespace("runner_hl"), -- highlight namespace
}

-- ════════════════════════════════════════════════════════════════
-- UTILITIES
-- ════════════════════════════════════════════════════════════════

--- Get information about the current buffer's file.
--- SCRATCHPAD: If the buffer has no name (unsaved/unnamed), write the buffer
--- content to a temporary file in /tmp/ with the correct filetype extension
--- and use that path for execution.
local function get_file_info()
	local bufnr = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local ft = vim.bo[bufnr].filetype

	-- Scratchpad support: unnamed buffer → write to /tmp
	if not bufname or bufname == "" then
		local ext_map = {
			cpp = "cpp",
			c = "c",
			python = "py",
			lua = "lua",
			go = "go",
			rust = "rs",
			asm = "asm",
			java = "java",
			javascript = "js",
			typescript = "ts",
			sh = "sh",
			bash = "sh",
			ruby = "rb",
			php = "php",
		}
		local ext = ext_map[ft] or ft
		local tmp_path = "/tmp/nvim_scratch_" .. os.time() .. "." .. ext

		-- Write buffer content to temp file
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local f = io.open(tmp_path, "w")
		if f then
			f:write(table.concat(lines, "\n") .. "\n")
			f:close()
		end

		local base = vim.fn.fnamemodify(tmp_path, ":t:r")
		local dir = vim.fn.fnamemodify(tmp_path, ":p:h")
		return {
			path = tmp_path,
			name = vim.fn.fnamemodify(tmp_path, ":t"),
			base = base,
			ext = ext,
			dir = dir,
			ft = ft,
			bufnr = bufnr,
			is_scratch = true,
		}
	end

	return {
		path = vim.fn.expand("%:p"),
		name = vim.fn.expand("%:t"),
		base = vim.fn.expand("%:t:r"),
		ext = vim.fn.expand("%:e"),
		dir = vim.fn.expand("%:p:h"),
		ft = ft,
		bufnr = bufnr,
		is_scratch = false,
	}
end

--- Detect if this is a Love2D project.
--- Prefers nvim_buf_get_lines (memory read) over readfile (disk read) when
--- the file is already loaded in a buffer, so it works on unsaved changes.
local function detect_love2d()
	local dir = vim.fn.expand("%:p:h")
	local main_path = dir .. "/main.lua"

	if vim.fn.filereadable(main_path) == 1 then
		-- Prefer reading from buffer if main.lua is already loaded
		local main_bufnr = vim.fn.bufnr(main_path)
		local content
		if main_bufnr ~= -1 and vim.api.nvim_buf_is_loaded(main_bufnr) then
			content = vim.api.nvim_buf_get_lines(main_bufnr, 0, -1, false)
		else
			content = vim.fn.readfile(main_path, "", 80)
		end
		for _, line in ipairs(content) do
			if line:match("love%.") then
				return true
			end
		end
	end

	if vim.fn.filereadable(dir .. "/conf.lua") == 1 then
		return true
	end

	return false
end

--- Detect if the current buffer uses LuaJIT FFI.
--- Reads from the buffer (memory), NOT from disk, so unsaved changes are detected.
local function detect_luajit()
	local bufnr = vim.api.nvim_get_current_buf()
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	local check_lines = math.min(80, line_count)
	local content = vim.api.nvim_buf_get_lines(bufnr, 0, check_lines, false)

	for _, line in ipairs(content) do
		if line:match("require%s*%(?['\"]ffi['\"]%)?") then
			return true
		end
	end
	return false
end

local function find_project_root()
	local markers = { ".git", "Makefile", "CMakeLists.txt", "Cargo.toml", "go.mod", "package.json", ".runner.lua" }
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

--- Check if CMakeLists.txt exists at the project root.
local function has_cmake()
	local root = find_project_root()
	return vim.fn.filereadable(root .. "/CMakeLists.txt") == 1
end

local function replace_placeholders(cmd, file_info, args)
	local project_root = find_project_root()
	local project_name = vim.fn.fnamemodify(project_root, ":t")

	-- SECURE: shellescape file-derived placeholders to prevent injection
	cmd = cmd:gsub("%%f", vim.fn.shellescape(file_info.path))
	cmd = cmd:gsub("%%b", vim.fn.shellescape(file_info.base))
	cmd = cmd:gsub("%%d", vim.fn.shellescape(file_info.dir))
	cmd = cmd:gsub("%%e", vim.fn.shellescape(file_info.ext))
	cmd = cmd:gsub("%%p", vim.fn.shellescape(project_root))
	cmd = cmd:gsub("%%P", vim.fn.shellescape(project_name))

	-- NOTE: %a is NOT escaped to allow the user to pass complex flag strings.
	cmd = cmd:gsub("%%a", args or "")

	-- Collapse whitespace
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

--- Parse environment variables from the beginning of an argument string.
--- Supports POSIX variable names: [A-Za-z_][A-Za-z0-9_]*
--- Example: "FOO=bar BAZ=1 --flag" → env={FOO="bar", BAZ="1"}, remaining="--flag"
local function parse_env_from_args(args)
	if not args or args == "" then
		return nil, ""
	end

	local env = {}
	local has_env = false
	local remaining = args

	while true do
		local var, val, rest = remaining:match("^([A-Za-z_][A-Za-z0-9_]*)=(%S+)%s*(.*)")
		if var then
			env[var] = val
			has_env = true
			remaining = rest
		else
			break
		end
	end

	if has_env then
		return env, remaining
	end
	return nil, args
end

-- ════════════════════════════════════════════════════════════════
-- OUTPUT WINDOW
-- ════════════════════════════════════════════════════════════════

--- Compute centered float geometry from config ratios.
local function float_geometry()
	local ui = Runner.config.ui
	local width = math.floor(vim.o.columns * ui.width)
	local height = math.floor(vim.o.lines * ui.height)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	return { width = width, height = height, row = row, col = col }
end

local function create_output_window()
	local geo = float_geometry()
	local ui = Runner.config.ui

	-- Reuse existing buffer or create new one
	if not Runner.state.output_buf or not vim.api.nvim_buf_is_valid(Runner.state.output_buf) then
		Runner.state.output_buf = vim.api.nvim_create_buf(false, true)
		vim.bo[Runner.state.output_buf].buftype = "nofile"
		vim.bo[Runner.state.output_buf].bufhidden = "hide"
		vim.bo[Runner.state.output_buf].swapfile = false
	end

	-- Guard: if window already valid, just focus it
	if Runner.state.output_win and vim.api.nvim_win_is_valid(Runner.state.output_win) then
		vim.api.nvim_set_current_win(Runner.state.output_win)
		return
	end

	Runner.state.output_win = vim.api.nvim_open_win(Runner.state.output_buf, true, {
		relative = "editor",
		width = geo.width,
		height = geo.height,
		row = geo.row,
		col = geo.col,
		style = "minimal",
		border = ui.border,
		title = " 󰐍 Code Runner ",
		title_pos = "center",
	})

	vim.wo[Runner.state.output_win].wrap = true
	vim.wo[Runner.state.output_win].cursorline = true

	-- Output window keymaps
	local buf = Runner.state.output_buf
	vim.keymap.set("n", "q", function()
		Runner.close_output()
	end, { buffer = buf, desc = "Close" })
	vim.keymap.set("n", "<Esc>", function()
		Runner.close_output()
	end, { buffer = buf, desc = "Close" })
	vim.keymap.set("n", "r", function()
		Runner.repeat_last()
	end, { buffer = buf, desc = "Repeat" })
	vim.keymap.set("n", "c", function()
		Runner.clear_output()
	end, { buffer = buf, desc = "Clear" })
	vim.keymap.set("n", "s", function()
		Runner.stop()
	end, { buffer = buf, desc = "Stop" })
end

local function ensure_output_window()
	if not Runner.state.output_win or not vim.api.nvim_win_is_valid(Runner.state.output_win) then
		create_output_window()
	end
end

--- Open a floating terminal window for interactive programs (stdin support).
--- termopen creates its own buffer, so we always make a fresh one.
local function create_term_window(cmd, cwd, env_tbl)
	local geo = float_geometry()
	local ui = Runner.config.ui

	-- Close any existing terminal window first
	if Runner.state.term_win and vim.api.nvim_win_is_valid(Runner.state.term_win) then
		vim.api.nvim_win_close(Runner.state.term_win, true)
		Runner.state.term_win = nil
	end

	-- Create a fresh buffer for the terminal
	Runner.state.term_buf = vim.api.nvim_create_buf(false, true)

	Runner.state.term_win = vim.api.nvim_open_win(Runner.state.term_buf, true, {
		relative = "editor",
		width = geo.width,
		height = geo.height,
		row = geo.row,
		col = geo.col,
		style = "minimal",
		border = ui.border,
		title = " 󰐍 Interactive Runner ",
		title_pos = "center",
	})

	vim.wo[Runner.state.term_win].wrap = true

	-- termopen runs inside the current buffer of the current window
	local term_opts = { cwd = cwd }
	if env_tbl then
		term_opts.env = env_tbl
	end

	term_opts.on_exit = function(_, exit_code)
		vim.schedule(function()
			if Runner.config.behavior.notify_on_complete then
				local msg = exit_code == 0 and "  Interactive session ended" or "  Exited (" .. exit_code .. ")"
				local level = exit_code == 0 and vim.log.levels.INFO or vim.log.levels.WARN
				vim.notify(msg, level)
			end
		end)
	end

	vim.fn.termopen(cmd, term_opts)

	-- Enter insert mode so the user can type immediately (stdin)
	vim.cmd("startinsert")

	-- Terminal-mode keymap to close the window
	vim.keymap.set("t", "<C-q>", function()
		vim.cmd("stopinsert")
		if Runner.state.term_win and vim.api.nvim_win_is_valid(Runner.state.term_win) then
			vim.api.nvim_win_close(Runner.state.term_win, true)
			Runner.state.term_win = nil
		end
	end, { buffer = Runner.state.term_buf, desc = "Close interactive runner" })
end

local function append_output(lines)
	if not Runner.state.output_buf or not vim.api.nvim_buf_is_valid(Runner.state.output_buf) then
		return
	end

	vim.schedule(function()
		if not Runner.state.output_buf or not vim.api.nvim_buf_is_valid(Runner.state.output_buf) then
			return
		end

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
		if
			Runner.config.behavior.auto_scroll
			and Runner.state.output_win
			and vim.api.nvim_win_is_valid(Runner.state.output_win)
		then
			local new_count = vim.api.nvim_buf_line_count(buf)
			pcall(vim.api.nvim_win_set_cursor, Runner.state.output_win, { new_count, 0 })
		end
	end)
end

-- ════════════════════════════════════════════════════════════════
-- SMART OUTPUT HIGHLIGHTING
-- ════════════════════════════════════════════════════════════════

--- Define highlight groups used by the runner output.
local function setup_highlight_groups()
	-- Only define once (idempotent)
	vim.api.nvim_set_hl(0, "RunnerError", { fg = "#f38ba8", bold = true }) -- red
	vim.api.nvim_set_hl(0, "RunnerWarning", { fg = "#f9e2af", bold = true }) -- yellow
	vim.api.nvim_set_hl(0, "RunnerSuccess", { fg = "#a6e3a1", bold = true }) -- green
	vim.api.nvim_set_hl(0, "RunnerInfo", { fg = "#89b4fa" }) -- blue
end
setup_highlight_groups()

--- Apply smart filetype and regex highlights to the output buffer.
--- @param mode string  The runner mode that was used (e.g. "asm_dump", "hex").
local function apply_output_highlights(mode)
	local buf = Runner.state.output_buf
	if not buf or not vim.api.nvim_buf_is_valid(buf) then
		return
	end

	-- ── Filetype-based syntax ──
	if mode == "asm_dump" or mode == "asm" or mode == "asm_bin" then
		vim.bo[buf].filetype = "asm"
	elseif mode == "hex" then
		vim.bo[buf].filetype = "xxd"
	else
		vim.bo[buf].filetype = "" -- reset; we use matchadd instead
	end

	-- ── Regex highlights via matchadd (window-local) ──
	local win = Runner.state.output_win
	if not win or not vim.api.nvim_win_is_valid(win) then
		return
	end

	-- Clear previous matches in this window
	vim.api.nvim_win_call(win, function()
		vim.fn.clearmatches()
		-- Case-insensitive error patterns
		vim.fn.matchadd("RunnerError", "\\c\\<error\\>")
		vim.fn.matchadd("RunnerError", "\\c\\<fatal\\>")
		vim.fn.matchadd("RunnerError", "\\c\\<fail\\(ed\\)\\?\\>")
		vim.fn.matchadd("RunnerError", "\\c\\<panic\\>")
		vim.fn.matchadd("RunnerError", "\\c\\<segfault\\>")
		vim.fn.matchadd("RunnerError", "\\c\\<exception\\>")
		vim.fn.matchadd("RunnerError", "\\c\\<traceback\\>")
		vim.fn.matchadd("RunnerWarning", "\\c\\<warn\\(ing\\)\\?\\>")
		vim.fn.matchadd("RunnerWarning", "\\c\\<deprecated\\>")
		vim.fn.matchadd("RunnerWarning", "\\c\\<note:\\>")
		vim.fn.matchadd("RunnerSuccess", "\\c\\<success\\>")
		vim.fn.matchadd("RunnerSuccess", "\\c\\<pass\\(ed\\)\\?\\>")
		vim.fn.matchadd("RunnerSuccess", "\\c\\<ok\\>")
		vim.fn.matchadd("RunnerSuccess", "✓")
		vim.fn.matchadd("RunnerError", "✗")
		vim.fn.matchadd("RunnerInfo", "^│.*")
		vim.fn.matchadd("RunnerInfo", "^┌.*")
		vim.fn.matchadd("RunnerInfo", "^├.*")
		vim.fn.matchadd("RunnerInfo", "^└.*")
	end)
end

-- ════════════════════════════════════════════════════════════════
-- DAP (DEBUG ADAPTER) HANDOFF
-- ════════════════════════════════════════════════════════════════

--- DAP configuration templates per filetype.
--- Each returns a dap.Configuration table for dap.run().
local dap_configs = {
	cpp = function(file_info)
		return {
			name = "Runner: Debug C++",
			type = "codelldb", -- also works with "cppdbg" if using cpptools
			request = "launch",
			program = file_info.dir .. "/" .. file_info.base,
			cwd = file_info.dir,
			stopOnEntry = false,
			args = {},
			-- Pre-launch: compile with debug symbols
			preLaunchTask = nil,
		}
	end,
	c = function(file_info)
		return {
			name = "Runner: Debug C",
			type = "codelldb",
			request = "launch",
			program = file_info.dir .. "/" .. file_info.base,
			cwd = file_info.dir,
			stopOnEntry = false,
			args = {},
		}
	end,
	rust = function(file_info)
		return {
			name = "Runner: Debug Rust",
			type = "codelldb",
			request = "launch",
			program = file_info.dir .. "/" .. file_info.base,
			cwd = file_info.dir,
			stopOnEntry = false,
			args = {},
		}
	end,
	go = function(file_info)
		return {
			name = "Runner: Debug Go",
			type = "delve",
			request = "launch",
			program = file_info.path,
			cwd = file_info.dir,
			args = {},
		}
	end,
	python = function(file_info)
		return {
			name = "Runner: Debug Python",
			type = "debugpy",
			request = "launch",
			program = file_info.path,
			cwd = file_info.dir,
			console = "integratedTerminal",
			args = {},
		}
	end,
}

-- ════════════════════════════════════════════════════════════════
-- RUNNER CORE
-- ════════════════════════════════════════════════════════════════

--- Main entry point. Runs the given mode for the current buffer.
--- @param mode string   The command key to look up ("run", "build", "win32", "hex", etc.)
--- @param args string|nil  User arguments (may contain leading VAR=VAL env vars).
--- @param opts table|nil   Optional overrides: { hex = bool, interactive = bool }
function Runner.run(mode, args, opts)
	opts = opts or {}
	local force_interactive = opts.interactive or false
	local file_info = get_file_info()
	local bufnr = file_info.bufnr
	local ft = file_info.ft

	-- ── Smart CMake ──
	-- If CMakeLists.txt is found at the project root for C/C++, override to
	-- the cmake configuration so the build system is respected automatically.
	local cmake_filetypes = { cpp = true, c = true }
	if cmake_filetypes[ft] and has_cmake() then
		ft = "cmake"
		if mode == "build_run" then
			mode = "run"
		end
	end

	-- ── Lua special detection ──
	if ft == "lua" and detect_love2d() then
		ft = "love2d"
	elseif ft == "lua" and mode == "run" then
		if detect_luajit() then
			-- FIX: use "luajit" to match the config key (was incorrectly "jit")
			mode = "luajit"
		end
	end

	local ft_config = get_filetype_config(ft)
	if not ft_config then
		vim.notify("  No runner for: " .. file_info.ft, vim.log.levels.ERROR)
		return
	end

	-- Resolve command template
	local cmd_template = ft_config[mode]
	if not cmd_template then
		cmd_template = ft_config["run"]
		mode = "run"
	end
	if not cmd_template then
		vim.notify("  No '" .. mode .. "' command for " .. file_info.ft, vim.log.levels.ERROR)
		return
	end

	-- If the value is a table (e.g. nested build/run keys), pick the best one
	if type(cmd_template) == "table" then
		cmd_template = cmd_template.build_run or cmd_template.run or cmd_template.build
		if not cmd_template then
			vim.notify("  No runnable command in table for mode: " .. mode, vim.log.levels.ERROR)
			return
		end
	end

	-- Auto-save (only named buffers)
	if Runner.config.behavior.save_before_run and vim.bo.modified and not file_info.is_scratch then
		vim.cmd("silent write")
	end

	-- Remember args
	local file_key = file_info.is_scratch and ("scratch:" .. ft) or file_info.path
	if args == nil and Runner.config.behavior.remember_args then
		args = Runner.state.args_history[file_key] or ""
	end
	if args and args ~= "" then
		Runner.state.args_history[file_key] = args
	end

	-- ── Environment variable parsing ──
	-- If the args string begins with VAR=VAL tokens, extract them and pass
	-- them via the `env` option of jobstart instead of inline in the command.
	local env, clean_args = parse_env_from_args(args or "")

	local cmd = replace_placeholders(cmd_template, file_info, clean_args)

	-- ── Hex dump output ──
	-- If opts.hex is true or mode is "hex", pipe the final command through xxd
	-- so the output window shows raw bytes instead of stdout text.
	if opts.hex or mode == "hex" then
		cmd = cmd .. " | xxd"
	end

	Runner.state.last_cmd = cmd
	Runner.state.last_cwd = file_info.dir
	Runner.state.last_env = env
	Runner.state.last_file = file_info.path
	Runner.state.last_mode = mode

	-- ── Decide: interactive terminal vs. jobstart ──
	local use_interactive = force_interactive or Runner.config.behavior.interactive

	if use_interactive then
		-- ── INTERACTIVE PATH: termopen in a floating terminal ──
		-- Auto-save before launching
		if Runner.config.behavior.save_before_run and vim.bo.modified and not file_info.is_scratch then
			vim.cmd("silent write")
		end
		create_term_window(cmd, file_info.dir, env)
		return
	end

	-- ── NON-INTERACTIVE PATH: jobstart with output buffer ──
	ensure_output_window()

	if Runner.config.behavior.clear_before_run then
		Runner.clear_output()
	end

	-- Header
	local icon = ft_config.icon or "󰐍"
	local display_cmd = #cmd > 55 and cmd:sub(1, 52) .. "..." or cmd
	local header = {
		"┌─────────────────────────────────────────────────────────────┐",
		"│ " .. icon .. "  " .. (ft_config.name or file_info.ft) .. "  │  " .. mode:upper(),
		"├─────────────────────────────────────────────────────────────┤",
		"│ File: " .. file_info.name,
		"│ Cmd:  " .. display_cmd,
	}
	if env then
		local env_str = ""
		for k, v in pairs(env) do
			env_str = env_str .. k .. "=" .. v .. " "
		end
		table.insert(header, "│ Env:  " .. env_str)
	end
	if file_info.is_scratch then
		table.insert(header, "│ Note: Running from scratchpad (/tmp)")
	end
	if Runner.state.watch[bufnr] then
		table.insert(header, "│  Watch mode ACTIVE")
	end
	table.insert(
		header,
		"└─────────────────────────────────────────────────────────────┘"
	)
	table.insert(header, "")
	append_output(header)

	-- Apply smart output highlighting based on mode
	apply_output_highlights(mode)

	-- ── Stop previous job on this buffer (if any) ──
	if Runner.state.jobs[bufnr] then
		pcall(vim.fn.jobstop, Runner.state.jobs[bufnr])
		Runner.state.jobs[bufnr] = nil
	end

	-- ── Launch job ──
	Runner.state.is_running = true
	local start_time = vim.uv.now()

	local job_opts = {
		cwd = file_info.dir,
		on_stdout = function(_, data)
			if data then
				append_output(data)
			end
		end,
		on_stderr = function(_, data)
			if data then
				append_output(data)
			end
		end,
		on_exit = function(_, exit_code)
			Runner.state.jobs[bufnr] = nil
			Runner.state.is_running = (next(Runner.state.jobs) ~= nil)

			local elapsed = (vim.uv.now() - start_time) / 1000
			local status_icon = exit_code == 0 and "✓" or "✗"
			local footer = {
				"",
				"─────────────────────────────────────────────────────────────",
				string.format(" %s Exit: %d │ Time: %.2fs", status_icon, exit_code, elapsed),
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
	}

	-- Inject parsed environment variables into the job
	if env then
		job_opts.env = env
	end

	local job_id = vim.fn.jobstart(cmd, job_opts)
	if job_id > 0 then
		Runner.state.jobs[bufnr] = job_id
	else
		Runner.state.is_running = (next(Runner.state.jobs) ~= nil)
		append_output({ " Failed to start job (id=" .. tostring(job_id) .. ")" })
	end
end

-- ════════════════════════════════════════════════════════════════
-- CONVENIENCE WRAPPERS
-- ════════════════════════════════════════════════════════════════

function Runner.run_with_args()
	local file_info = get_file_info()
	local file_key = file_info.is_scratch and ("scratch:" .. file_info.ft) or file_info.path
	local last_args = Runner.state.args_history[file_key] or ""

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

--- Run the current file and pipe output through xxd for hex dump inspection.
--- Useful for inspecting shellcode output, raw binaries, or protocol data.
function Runner.run_hex()
	Runner.run("run", nil, { hex = true })
end

--- Run the current file in interactive terminal mode (termopen + startinsert).
--- Use this for programs that read from stdin (e.g. std::cin, input(), scanf).
function Runner.run_interactive()
	Runner.run("run", nil, { interactive = true })
end

--- Debug the current file via nvim-dap.
--- Builds with debug symbols first, then hands off to DAP.
--- Requires nvim-dap to be installed and the appropriate debug adapter configured.
function Runner.debug()
	local dap = package.loaded["dap"]
	if not dap then
		-- Try a lazy require
		local ok
		ok, dap = pcall(require, "dap")
		if not ok then
			vim.notify(
				"  nvim-dap is not installed.\n"
					.. "  Install it to use debug mode:\n"
					.. "  https://github.com/mfussenegger/nvim-dap",
				vim.log.levels.ERROR
			)
			return
		end
	end

	local file_info = get_file_info()
	local ft = file_info.ft

	local config_fn = dap_configs[ft]
	if not config_fn then
		vim.notify(
			"  No DAP config for filetype: " .. ft .. "\n" .. "  Supported: cpp, c, rust, go, python",
			vim.log.levels.WARN
		)
		return
	end

	-- Auto-save
	if Runner.config.behavior.save_before_run and vim.bo.modified and not file_info.is_scratch then
		vim.cmd("silent write")
	end

	-- For compiled languages, build with debug symbols first
	local compiled = { cpp = true, c = true, rust = true }
	if compiled[ft] then
		local ft_config = get_filetype_config(ft)
		if ft_config and ft_config.build then
			local build_cmd = replace_placeholders(ft_config.build, file_info, "")
			vim.notify("  Building for debug: " .. build_cmd:sub(1, 50), vim.log.levels.INFO)
			local result = vim.fn.system(build_cmd)
			if vim.v.shell_error ~= 0 then
				vim.notify("  Build failed:\n" .. result, vim.log.levels.ERROR)
				return
			end
		end
	end

	-- Construct and launch DAP config
	local dap_cfg = config_fn(file_info)

	-- Allow the user to inject args from history
	local file_key = file_info.is_scratch and ("scratch:" .. ft) or file_info.path
	local saved_args = Runner.state.args_history[file_key]
	if saved_args and saved_args ~= "" then
		local arg_list = {}
		for arg in saved_args:gmatch("%S+") do
			table.insert(arg_list, arg)
		end
		dap_cfg.args = arg_list
	end

	vim.notify("  Launching DAP: " .. dap_cfg.name, vim.log.levels.INFO)
	dap.run(dap_cfg)
end

--- Stop the job associated with the CURRENT buffer only.
--- Other buffers' jobs continue running undisturbed (multi-process support).
function Runner.stop()
	local bufnr = vim.api.nvim_get_current_buf()
	local job_id = Runner.state.jobs[bufnr]

	if job_id then
		pcall(vim.fn.jobstop, job_id)
		Runner.state.jobs[bufnr] = nil
		Runner.state.is_running = (next(Runner.state.jobs) ~= nil)
		append_output({ "", " ⏹ Process stopped (buf " .. bufnr .. ")", "" })
		vim.notify(" ⏹ Stopped", vim.log.levels.WARN)
	else
		-- If called from the output window, stop the most recent job
		local any_stopped = false
		for buf, jid in pairs(Runner.state.jobs) do
			pcall(vim.fn.jobstop, jid)
			Runner.state.jobs[buf] = nil
			any_stopped = true
			break
		end
		if any_stopped then
			Runner.state.is_running = (next(Runner.state.jobs) ~= nil)
			append_output({ "", " ⏹ Process stopped", "" })
			vim.notify(" ⏹ Stopped", vim.log.levels.WARN)
		else
			vim.notify("  No running process for this buffer", vim.log.levels.INFO)
		end
	end
end

--- Stop ALL running jobs across all buffers.
function Runner.stop_all()
	for buf, job_id in pairs(Runner.state.jobs) do
		pcall(vim.fn.jobstop, job_id)
		Runner.state.jobs[buf] = nil
	end
	Runner.state.is_running = false
	append_output({ "", " ⏹ All processes stopped", "" })
	vim.notify(" ⏹ All stopped", vim.log.levels.WARN)
end

function Runner.repeat_last()
	if Runner.state.last_cmd then
		ensure_output_window()
		if Runner.config.behavior.clear_before_run then
			Runner.clear_output()
		end
		append_output({ " Repeating...", "", "$ " .. Runner.state.last_cmd, "" })

		local bufnr = vim.api.nvim_get_current_buf()

		-- Stop previous job on this buffer
		if Runner.state.jobs[bufnr] then
			pcall(vim.fn.jobstop, Runner.state.jobs[bufnr])
			Runner.state.jobs[bufnr] = nil
		end

		Runner.state.is_running = true

		local job_opts = {
			cwd = Runner.state.last_cwd,
			on_stdout = function(_, data)
				if data then
					append_output(data)
				end
			end,
			on_stderr = function(_, data)
				if data then
					append_output(data)
				end
			end,
			on_exit = function(_, code)
				Runner.state.jobs[bufnr] = nil
				Runner.state.is_running = (next(Runner.state.jobs) ~= nil)
				append_output({ "", " Exit: " .. code })
			end,
		}

		if Runner.state.last_env then
			job_opts.env = Runner.state.last_env
		end

		local job_id = vim.fn.jobstart(Runner.state.last_cmd, job_opts)
		if job_id > 0 then
			Runner.state.jobs[bufnr] = job_id
		end
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

--- Toggle watch mode for the current buffer.
--- When active, saves trigger an automatic Runner.run("run").
function Runner.toggle_watch()
	local bufnr = vim.api.nvim_get_current_buf()

	if Runner.state.watch[bufnr] then
		-- Disable watch
		pcall(vim.api.nvim_del_autocmd, Runner.state.watch[bufnr])
		Runner.state.watch[bufnr] = nil
		vim.notify("  Watch mode OFF (buf " .. bufnr .. ")", vim.log.levels.INFO)
	else
		-- Enable watch
		local au_id = vim.api.nvim_create_autocmd("BufWritePost", {
			buffer = bufnr,
			callback = function()
				-- Small delay so the write completes fully
				vim.defer_fn(function()
					Runner.run("run", nil)
				end, 100)
			end,
			desc = "Runner: watch mode auto-run",
		})
		Runner.state.watch[bufnr] = au_id
		vim.notify("  Watch mode ON (buf " .. bufnr .. ") — auto-runs on save", vim.log.levels.INFO)
	end
end

function Runner.show_info()
	local file_info = get_file_info()
	local ft_config = get_filetype_config(file_info.ft)

	local lines = {
		"󰐍 Runner Info",
		"",
		" File: " .. file_info.name,
		" Type: " .. file_info.ft,
		" Buf:  " .. file_info.bufnr,
	}

	if file_info.is_scratch then
		table.insert(lines, " Mode: Scratchpad")
	end

	-- Watch mode indicator
	if Runner.state.watch[file_info.bufnr] then
		table.insert(lines, "  Watch: ACTIVE (auto-run on save)")
	end

	-- DAP availability
	local has_dap = package.loaded["dap"] ~= nil or pcall(require, "dap")
	table.insert(lines, " DAP:  " .. (has_dap and "available" or "not installed"))

	local active = 0
	for _ in pairs(Runner.state.jobs) do
		active = active + 1
	end
	table.insert(lines, " Jobs: " .. active .. " active")

	if has_cmake() then
		table.insert(lines, " CMake: detected (CMakeLists.txt)")
	end

	table.insert(lines, "")

	if ft_config then
		table.insert(lines, " Commands:")
		for m, cmd in pairs(ft_config) do
			if type(cmd) == "string" then
				table.insert(lines, "   " .. m .. ": " .. cmd:sub(1, 45))
			elseif type(cmd) == "table" and m ~= "icon" and m ~= "name" then
				table.insert(lines, "   " .. m .. ": (multi-command)")
			end
		end
	else
		table.insert(lines, "  No config for this filetype")
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end

function Runner.pick_mode()
	local file_info = get_file_info()
	local ft = file_info.ft

	-- Also offer cmake modes if detected
	if has_cmake() then
		ft = "cmake"
	end

	local ft_config = get_filetype_config(ft)

	if not ft_config then
		vim.notify("  No runner for: " .. file_info.ft, vim.log.levels.ERROR)
		return
	end

	local modes = {}
	for m, cmd in pairs(ft_config) do
		if type(cmd) == "string" then
			table.insert(modes, { mode = m, cmd = cmd })
		elseif type(cmd) == "table" and m ~= "icon" and m ~= "name" then
			local display = cmd.build_run or cmd.run or cmd.build or "(table)"
			table.insert(modes, { mode = m, cmd = display })
		end
	end

	-- Sort for consistent display
	table.sort(modes, function(a, b)
		return a.mode < b.mode
	end)

	-- Add virtual modes
	table.insert(modes, { mode = "hex (run + xxd)", cmd = "run | xxd" })
	table.insert(modes, { mode = "interactive (terminal)", cmd = "run (termopen + stdin)" })

	vim.ui.select(modes, {
		prompt = "  Select mode:",
		format_item = function(item)
			return " " .. item.mode .. " │ " .. item.cmd:sub(1, 45)
		end,
	}, function(choice)
		if choice then
			if choice.mode:match("^hex") then
				Runner.run_hex()
			elseif choice.mode:match("^interactive") then
				Runner.run_interactive()
			else
				Runner.run(choice.mode, nil)
			end
		end
	end)
end

-- ════════════════════════════════════════════════════════════════
-- SETUP KEYMAPS
-- ════════════════════════════════════════════════════════════════

local map = vim.keymap.set

map("n", "<leader>rr", function()
	Runner.run("run", nil)
end, { desc = "Run file" })
map("n", "<leader>ra", function()
	Runner.run_with_args()
end, { desc = "Run with args" })
map("n", "<leader>rb", function()
	Runner.build()
end, { desc = "Build" })
map("n", "<leader>rx", function()
	Runner.build_run()
end, { desc = "Build & Run" })
map("n", "<leader>rt", function()
	Runner.test()
end, { desc = "Run tests" })
map("n", "<leader>rs", function()
	Runner.stop()
end, { desc = "Stop (current buf)" })
map("n", "<leader>rS", function()
	Runner.stop_all()
end, { desc = "Stop all" })
map("n", "<leader>rc", function()
	Runner.clear_output()
end, { desc = "Clear output" })
map("n", "<leader>ro", function()
	Runner.toggle_output()
end, { desc = "Toggle output" })
map("n", "<leader>rl", function()
	Runner.repeat_last()
end, { desc = "Repeat last" })
map("n", "<leader>ri", function()
	Runner.show_info()
end, { desc = "Runner info" })
map("n", "<leader>rp", function()
	Runner.pick_mode()
end, { desc = "Pick mode" })
map("n", "<leader>rh", function()
	Runner.run_hex()
end, { desc = "Run + hex dump" })
map("n", "<leader>rn", function()
	Runner.run_interactive()
end, { desc = "Run interactive" })
map("n", "<leader>rd", function()
	Runner.debug()
end, { desc = "Debug (DAP)" })
map("n", "<leader>rw", function()
	Runner.toggle_watch()
end, { desc = "Toggle watch mode" })

map("n", "<F6>", function()
	Runner.run("run", nil)
end, { desc = "Quick run" })
map("n", "<F7>", function()
	Runner.run_with_args()
end, { desc = "Run with args" })

-- Global access
_G.Runner = Runner
return {}
