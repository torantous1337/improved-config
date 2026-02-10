-- ============================================================================
--  KEYMAPS
-- ============================================================================

local map = vim.keymap.set
local opts = { silent = true }

-- ════════════════════════════════════════════════════════════════
-- NEOVIM CONFIG NAVIGATION
-- ════════════════════════════════════════════════════════════════
map("n", "<leader>nc", "<cmd>e ~/.config/nvim/init.lua<cr>", { desc = "Edit init.lua" })
map("n", "<leader>no", "<cmd>e ~/.config/nvim/lua/torantous/core/options.lua<cr>", { desc = "Edit options" })
map("n", "<leader>nk", "<cmd>e ~/.config/nvim/lua/torantous/core/keymaps.lua<cr>", { desc = "Edit keymaps" })
map("n", "<leader>np", "<cmd>e ~/.config/nvim/lua/torantous/plugins/<cr>", { desc = "Browse plugins folder" })

-- Telescope into config
map("n", "<leader>nf", function()
  require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
end, { desc = "Find config files" })

map("n", "<leader>ng", function()
  require("telescope.builtin").live_grep({ cwd = "~/.config/nvim" })
end, { desc = "Grep config files" })

-- Quick reload config
map("n", "<leader>nr", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })

-- Open lazy plugin manager
map("n", "<leader>nl", "<cmd>Lazy<cr>", { desc = "Lazy plugins" })
map("n", "<leader>nm", "<cmd>Mason<cr>", { desc = "Mason LSP" })

-- ════════════════════════════════════════════════════════════════
-- GENERAL
-- ════════════════════════════════════════════════════════════════
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>qq", "<cmd>qa! <cr>", { desc = "Quit all" })
-- Open tree at current file's location
map("n", "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "File explorer (current file)" })
-- ════════════════════════════════════════════════════════════════
-- BUFFERS
-- ════════════════════════════════════════════════════════════════
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all but current" })

-- ════════════════════════════════════════════════════════════════
-- TELESCOPE
-- ════════════════════════════════════════════════════════════════
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })

-- ════════════════════════════════════════════════════════════════
-- WINDOW NAVIGATION
-- ════════════════════════════════════════════════════════════════
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase width" })

-- ════════════════════════════════════════════════════════════════
-- DAP (Debugging)
-- ════════════════════════════════════════════════════════════════
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP UI" })
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<F5>", function() require("dap").continue() end, { desc = "DAP Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "DAP Step Over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "DAP Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "DAP Step Out" })

-- ════════════════════════════════════════════════════════════════
-- DIAGNOSTICS
-- ════════════════════════════════════════════════════════════════
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ════════════════════════════════════════════════════════════════
-- QUALITY OF LIFE
-- ════════════════════════════════════════════════════════════════
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search (centered)" })
-- ════════════════════════════════════════════════════════════════
-- 🔥 POWER USER TRICKS
-- ════════════════════════════════════════════════════════════════

-- Quick select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Duplicate line(s)
map("n", "<leader>d", "yyp", { desc = "Duplicate line" })
map("v", "<leader>d", "y'>p", { desc = "Duplicate selection" })

-- Delete without yanking (black hole register)
map("n", "<leader>x", '"_x', { desc = "Delete char (no yank)" })
map("n", "<leader>D", '"_dd', { desc = "Delete line (no yank)" })
map("v", "<leader>D", '"_d', { desc = "Delete selection (no yank)" })

-- Paste without losing clipboard (paste over selection)
map("v", "p", '"_dP', { desc = "Paste (keep clipboard)" })

-- Add blank lines without entering insert mode
map("n", "<leader>o", "o<Esc>", { desc = "Blank line below" })
map("n", "<leader>O", "O<Esc>", { desc = "Blank line above" })

-- Quick find and replace (word under cursor)
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })

-- Quick find and replace (visual selection)
map("v", "<leader>sr", '"hy:%s/<C-r>h/<C-r>h/gI<Left><Left><Left>', { desc = "Replace selection" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down (already have this but improved)
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ": m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Quick save shortcuts
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("i", "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save" })

-- Close buffer without closing window
map("n", "<leader>bd", "<cmd>bp|bd #<cr>", { desc = "Close buffer (keep window)" })

-- Split navigation (already have but adding resize)
map("n", "<C-h>", "<C-w>h", { desc = "Go left" })
map("n", "<C-j>", "<C-w>j", { desc = "Go down" })
map("n", "<C-k>", "<C-w>k", { desc = "Go up" })
map("n", "<C-l>", "<C-w>l", { desc = "Go right" })

-- Split creation
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })

-- Tab management
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>]", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>[", "<cmd>tabprev<cr>", { desc = "Prev tab" })

-- Quick terminal
map("n", "<leader>tt", "<cmd>split | terminal<cr>", { desc = "Terminal (horizontal)" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal (vertical)" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Quick jump to start/end of line
map("n", "H", "^", { desc = "Start of line" })
map("n", "L", "$", { desc = "End of line" })
map("v", "H", "^", { desc = "Start of line" })
map("v", "L", "$", { desc = "End of line" })

-- Increment/decrement numbers
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })

-- Quick fix list navigation
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Prev quickfix" })

-- Search within visual selection
map("v", "/", "<Esc>/\\%V", { desc = "Search in selection" })

-- Redo with U (easier than C-r)
map("n", "U", "<C-r>", { desc = "Redo" })

-- Quick chmod +x for scripts
map("n", "<leader>cx", "<cmd>!chmod +x %<cr>", { desc = "Make executable" })

-- Quick yank to system clipboard
map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- Quick paste from system clipboard
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste before from clipboard" })

-- Toggle word wrap
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle word wrap" })

-- Toggle relative line numbers
map("n", "<leader>ul", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers" })

-- Toggle spell check
map("n", "<leader>us", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })

-- Dismiss notifications
map("n", "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, { desc = "Dismiss notifications" })
-- ════════════════════════════════════════════════════════════════
-- 🔥 INSERT MODE TRICKS
-- ════════════════════════════════════════════════════════════════

-- Quick escape (jk or jj is faster than reaching for Esc)
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Undo break points (create undo points at punctuation)
map("i", "!", "!<C-g>u", { desc = "Undo breakpoint" })
map("i", "?", "?<C-g>u", { desc = "Undo breakpoint" })

-- Navigation without leaving insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- Jump to start/end of line in insert mode
map("i", "<C-a>", "<Home>", { desc = "Start of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

-- Delete word backward/forward (like terminal)
map("i", "<C-w>", "<C-\\><C-o>db", { desc = "Delete word backward" })
map("i", "<A-d>", "<C-\\><C-o>dw", { desc = "Delete word forward" })

-- Delete to end/start of line
map("i", "<C-k>", "<C-\\><C-o>D", { desc = "Delete to end of line" })
map("i", "<C-u>", "<C-\\><C-o>d^", { desc = "Delete to start of line" })

-- New line without breaking current line
map("i", "<C-Enter>", "<Esc>o", { desc = "New line below" })
map("i", "<C-S-Enter>", "<Esc>O", { desc = "New line above" })

-- Move current line up/down from insert mode
map("i", "<A-j>", "<Esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })

-- Duplicate line from insert mode
map("i", "<C-d>", "<Esc>yypi", { desc = "Duplicate line" })

-- Quick paste from clipboard in insert mode
map("i", "<C-v>", "<C-r>+", { desc = "Paste from clipboard" })

-- Quick brackets/quotes (auto-pair style but manual control)
map("i", "<A-9>", "()<Left>", { desc = "Insert ()" })
map("i", "<A-[>", "[]<Left>", { desc = "Insert []" })
map("i", "<A-{>", "{}<Left>", { desc = "Insert {}" })
map("i", "<A-'>", "''<Left>", { desc = "Insert ''" })
map("i", '<A-">', '""<Left>', { desc = 'Insert ""' })
map("i", "<A-`>", "``<Left>", { desc = "Insert ``" })

-- Surround word under cursor (from insert mode)
map("i", '<A-s>"', '<Esc>ciw""<Esc>P', { desc = "Surround with quotes" })
map("i", "<A-s>'", "<Esc>ciw''<Esc>P", { desc = "Surround with single quotes" })
map("i", "<A-s>(", "<Esc>ciw()<Esc>P", { desc = "Surround with parens" })
map("i", "<A-s>{", "<Esc>ciw{}<Esc>P", { desc = "Surround with braces" })

-- Uppercase/lowercase word
map("i", "<A-u>", "<Esc>viwUea", { desc = "Uppercase word" })
map("i", "<A-l>", "<Esc>viwuea", { desc = "Lowercase word" })

-- Quick comment toggle (go to normal, toggle, back to insert)
map("i", "<C-/>", "<Esc>gcc`]a", { desc = "Toggle comment" })

-- Insert common snippets/templates
map("i", "<C-t>d", "// TODO: ", { desc = "Insert TODO" })
map("i", "<C-t>f", "// FIXME: ", { desc = "Insert FIXME" })
map("i", "<C-t>n", "// NOTE: ", { desc = "Insert NOTE" })
map("i", "<C-t>h", "// HACK: ", { desc = "Insert HACK" })

map("i", "<A-m>", "-- HACK THE WORLD", {desc = "Insert TEXT"})
-- Quick date/time insertion
map("i", "<C-t>t", "<C-r>=strftime('%Y-%m-%d %H:%M:%S')<cr>", { desc = "Insert datetime" })
map("i", "<C-t>D", "<C-r>=strftime('%Y-%m-%d')<cr>", { desc = "Insert date" })
  
-- Insert filename
map("i", "<C-t>p", "<C-r>=expand('%:t')<cr>", { desc = "Insert filename" })
map("i", "<C-t>P", "<C-r>=expand('%:p')<cr>", { desc = "Insert full path" })
-- Open New Tab
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })


-- check lua version
-- Show Lua version info
map("n", "<leader>rv", function()
  local output = vim.fn.system("lua -v && luajit -v 2>/dev/null || echo 'LuaJIT not installed'")
  vim.notify(output, vim.log.levels.INFO, { title = "Lua Versions" })
end, { desc = "Show Lua versions" })

-- LuaJit Quick Run
map("n", "<leader>rj", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("split | terminal luajit '" ..  file .. "'")
end, { desc = "Run with LuaJIT" })
-- Show Lua version info
map("n", "<leader>rv", function()
  local output = vim.fn.system("lua -v && luajit -v 2>/dev/null || echo 'LuaJIT not installed'")
  vim.notify(output, vim.log.levels.INFO, { title = "Lua Versions" })
end, { desc = "Show Lua versions" })
-- UI Toggles
map("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Zen Mode" })
map("n", "<leader>ut", "<cmd>Twilight<cr>", { desc = "Twilight" })
map("n", "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, { desc = "Dismiss notifications" })
-- ════════════════════════════════════════════════════════════════
-- DIAGNOSTICS / ERRORS
-- ════════════════════════════════════════════════════════════════

-- Navigate diagnostics (all types)
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

-- Navigate ONLY errors (skip warnings/hints)
map("n", "]e", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })

map("n", "[e", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })

-- Navigate ONLY warnings
map("n", "]w", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Next warning" })

map("n", "[w", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
end, { desc = "Prev warning" })

-- Show diagnostic in floating window
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Show all diagnostics in quickfix list
map("n", "<leader>xq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })

-- Show buffer diagnostics in location list
map("n", "<leader>xl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Telescope diagnostics (if you have telescope)
map("n", "<leader>xx", "<cmd>Telescope diagnostics<cr>", { desc = "Telescope diagnostics" })
map("n", "<leader>xX", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Buffer diagnostics" })
 
-- Keymap 1: Replace ". " with "." (ignoring ".. ")
vim.keymap.set('n', '<leader>jr', function()
    -- The regex explained:
    -- \.     -> Matches a literal dot
    -- \@<!   -> Negative lookbehind (ensures the previous char was NOT the atom before)
    -- \.     -> Matches the literal dot we want to change
    -- (space)-> Matches the space we want to remove
    vim.cmd([[:%s/\.\@<!\. /./g]])
end, { desc = 'Remove space after single dots' })

-- Keymap 2: Format the current buffer
vim.keymap.set('n', '<leader>jf', function()
    vim.lsp.buf.format()
end, { desc = 'Format file using LSP' })

