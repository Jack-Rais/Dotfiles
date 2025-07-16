
-- Imposta dei filepath di default
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets"
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Impostare il mapleader
vim.g.mapleader = " "


-- Bootstrap lazy.nvim
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")
require("lazy").setup({ spec = { { import = "plugins" } } }, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")


require "options"
vim.schedule(function()
    require "mappers"
end)

