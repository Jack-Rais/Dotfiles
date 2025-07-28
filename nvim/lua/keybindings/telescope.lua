local M = {}

function M.get_mappings()
    local builtin = require("telescope.builtin")
    local neoclip = require("telescope").extensions.neoclip

    return {
        -- Find files and text
        { "<leader>ff", function() builtin.find_files() end, desc = "Find Files Telescope" },
        { "<leader>fg", function() builtin.live_grep() end, desc = "Find Grep Telescope" },
        { "<leader>fb", function() builtin.find_buffers() end, desc = "Find Buffers Telescope"},
        { "<leader>fs", function() builtin.grep_string() end, desc = "Find Word Under Cursor Telescope" },
        { "<leader>fz", function() builtin.current_buffer_fuzzy_find() end, desc = "Find Word In Buffer Telescope" },

        -- LSP
        { "<leader>ls", function() builtin.lsp_document_symbols() end, desc = "LSP Document Symbol Telescope" },
        { "<leader>lS", function() builtin.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols Telescope" },
        { "<leader>lr", function() builtin.lsp_references() end, desc = "LSP References Telescope" },
        { "<leader>ld", function() builtin.lsp_definitions() end, desc = "LSP Word Definitions Telescope" },
        { "<leader>lt", function() builtin.lsp_type_definitions() end, desc = "LSP Word Type Definitions Telescope" },

        -- Git
        { "<leader>gf", function() builtin.git_files() end, desc = "Git Files Telescope" },
        { "<leader>gs", function() builtin.git_status() end, desc = "Git Status Telescope" },
        { "<leader>gc", function() builtin.git_commits() end, desc = "Git Commits Telescope" },
        { "<leader>gt", function() builtin.git_stash() end, desc = "Git Stash Telescope" },
        { "<leader>gb", function() builtin.git_branches() end, desc = "Git Branches Telescope" },

        -- Vim internals
        { "<leader>vo", function() builtin.vim_options() end, desc = "Vim Options Telescope" },
        { "<leader>vc", function() builtin.commands() end, desc = "Vim Commands Telescope" },
        { "<leader>vk", function() builtin.keymaps() end, desc = "Vim Keymaps Telescope" },

        -- Neoclip
        { "<leader>y", "<cmd>Telescope neoclip extra=star<CR>", desc = "Clipboard Yanks Telescope" },
        { "<leader>Y", "<cmd>Telescope neoclip plus<CR>", desc = "System Yanks Telescope" },

        -- Colorscheme
        { "<leader>th", function() builtin.colorscheme() end, desc = "Find Colorscheme Telescope" },
    }
end

return M
