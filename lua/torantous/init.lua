-- Bootstrap lazy.nvim and load core
require("torantous.core.options")
require("torantous.core.keymaps")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("torantous.plugins", {
  rocks = { enabled = false },
  change_detection = { notify = false },
})
