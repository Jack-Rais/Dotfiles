
local builtin = require("telescope.builtin")
local neoclip = require("telescope").extensions.neoclip

return {

    {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require("neoclip").setup({})
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.8'
        dependencies = { 'nvim-lua/plenary.nvim', 'AckslD/nvim-neoclip.lua' },

        config = function(_, opts)
            local telescope = require("telescope")
            telesocpe.setup(opts)
            telescope.load_extension("neoclip")
        end,

        cmd = "Telescope",
        keys = {

            -- Cercare file e parole
            { "<leader>ff", function() builtin.find_files() end, desc = "Find Files Telescope" },
            { "<leader>fg", function() builtin.live_grep() end, desc = "Find Grep Telescope" },
            { "<leader>fb", function() builtin.find_buffers() end, desc = "Find Buffers Telescope"},
            { "<leader>fs", function() builtin.grep_string() end, desc = "Find Word Under Cursor Telescope" },
            { "<leader>fz", function() builtin.current_buffer_fuzzy_find() end, desc = "Find Word In Buffer Telescope" },

            -- Cercare con LSP
            { "<leader>ls", function() builtin.lsp_document_symbols() end, desc = "LSP Document Symbol Telescope" },
            { "<leader>lS", function() builtin.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols Telescope" },
            { "<leader>lr", function() builtin.lsp_references() end, desc = "LSP References Telescope" },
            { "<leader>ld", function() builtin.lsp_definitions() end, desc = "LSP Word Definitions Telescope" },
            { "<leader>lt", function() builtin.lsp_type_definitions() end, desc = "LSP Word Type Definitions Telescope" },

            -- Cercare in git
            { "<leader>gf", function() builtin.git_files() end, desc = "Git Files Telescope" },
            { "<leader>gs", function() builtin.git_status() end, desc = "Git Status Telescope" },
            { "<leader>gc", function() builtin.git_commits() end, desc = "Git Commits Telescope" },
            { "<leader>gt", function() builtin.git_stash() end, desc = "Git Stash Telescope" },
            { "<leader>gb", function() builtin.git_branches() end, desc = "Git Branches Telescope" },

            -- Cercare in vim
            { "<leader>vo", function() builtin.vim_options() end, desc = "Vim Options Telescope" },
            { "<leader>vc", function() builtin.commands() end, desc = "Vim Commands Telescope" },
            { "<leader>vk", function() builtin.keymaps() end, desc = "Vim Keymaps Telescope" },

            -- Cercare in neoclip
            { "<leader>y", function() neoclip.default({ extra = "star" }) end, desc = "Clipboard Yanks Telescope" },
            { "<leader>Y", function() neoclip.default({ extra = "plus" }) end, desc = "System Yanks Telescope" },

            -- Cercare il colorscheme
            { "<leader>th", function() builtin.colorscheme() end, desc = "Find Colorscheme Telescope" },
        },

        opts = {
            defaults = {
                file_ignore_patterns = { ".git/", "target/" },
            }
        },

        pickers = {
            find_files = { hidden = true },
        }
    }

}
