-- ============================================================
-- OPTIONS
-- ============================================================

vim.g.mapleader = " "

-- ============================================================
-- PLUGINS
-- ============================================================

vim.pack.add({

    -- Core LSP and completion
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1.0.0")
    },
    "https://github.com/rafamadriz/friendly-snippets",

    -- Treesitter and parsing
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main"
    },

    -- UI and appearance
    "https://github.com/romgrk/barbar.nvim.git",
    "https://github.com/olimorris/onedarkpro.nvim",
    "https://github.com/brenoprata10/nvim-highlight-colors",
    "https://github.com/lukas-reineke/indent-blankline.nvim",

    -- File navigation and search
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-lua/plenary.nvim.git",
    "https://github.com/nvim-telescope/telescope.nvim",

    -- Editing enhancements
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/numToStr/Comment.nvim",
    "https://github.com/LudoPinelli/comment-box.nvim",
    {
        src = "https://github.com/jake-stewart/multicursor.nvim",
        version = '1.0'
    },

    -- Git integration
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/esmuellert/codediff.nvim",

    -- Utilities
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/mcauley-penney/tidy.nvim",
    "https://github.com/jiaoshijie/undotree"
})

require('mason').setup()
require('mason-lspconfig').setup()
require('plugins.blink')

require('plugins.treesitter')

require('plugins.buffers')
require('plugins.theme')
require('plugins.colors')
require('ibl').setup()

require('plugins.nvim_tree')
require('plugins.telescope')

require('nvim-autopairs').setup()
require('plugins.surround')
require('Comment').setup()
require('comment-box').setup()
require('multicursor-nvim').setup()

require('gitsigns').setup()
require('codediff').setup()

require('plugins.terminal')
require('tidy').setup()
require('undotree').setup()

-- ============================================================
-- IMPORTS
-- ============================================================

require("options")
require("executors").setup()
require("keybindings")
