
-- Impostare il mapleader
vim.g.mapleader = " "

require("options")
require("keybindings").setup()

-- Imposta dei filepath di default
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")
require("lazy").setup({ spec = { { import = "plugins" } } }, lazy_config)
