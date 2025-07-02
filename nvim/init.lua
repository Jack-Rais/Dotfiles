
-- Imposta dei filepath di default
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.lua_snippets_path = vim.fn.stdpath "config" .. "/lua/snippets"
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Impostare il mapleader
vim.g.mapleader = " "

-- Installare lazy.nvim se non è già presente nel systema
if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

-- Impostare la cartella di lazy.nvim come la prima che deve caricare
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
    require "mappings"
end)
