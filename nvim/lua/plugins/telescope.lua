
require('telescope').setup({
    defaults = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "-L" },
        vimgrep_arguments = {
            "rg", "--vimgrep", "--color=never", "--no-heading",
            "--with-filename", "--line-number", "--column",
            "--smart-case", "--hidden", "-L",
        },
    },

    pickers = {
        find_files = { hidden = true },
    }

})


local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>ff", function() builtin.find_files() end) -- "Find Files Telescope"
map("n", "<leader>fg", function() builtin.live_grep() end) -- "Find Grep Telescope"
map("n", "<leader>fb", function() builtin.find_buffers() end) -- "Find Buffers Telescope
map("n", "<leader>fs", function() builtin.grep_string() end) -- "Find Word Under Cursor Telescope"
map("n", "<leader>fz", function() builtin.current_buffer_fuzzy_find() end) -- "Find Word In Buffer Telescope"

-- LSP
map("n", "<leader>ls", function() builtin.lsp_document_symbols() end) -- "LSP Document Symbol Telescope"
map("n", "<leader>lS", function() builtin.lsp_workspace_symbols() end) -- "LSP Workspace Symbols Telescope"
map("n", "<leader>lr", function() builtin.lsp_references() end) -- "LSP References Telescope"
map("n", "<leader>ld", function() builtin.lsp_definitions() end) -- "LSP Word Definitions Telescope"
map("n", "<leader>lt", function() builtin.lsp_type_definitions() end) -- "LSP Word Type Definitions Telescope"
map("n", "<leader>le", function() builtin.diagnostics() end) -- "LSP diagnostics list"

-- Git
map("n", "<leader>gf", function() builtin.git_files() end) -- "Git Files Telescope"
map("n", "<leader>gs", function() builtin.git_status() end) -- "Git Status Telescope"
map("n", "<leader>gc", function() builtin.git_commits() end) -- "Git Commits Telescope"
map("n", "<leader>gt", function() builtin.git_stash() end) -- "Git Stash Telescope"
map("n", "<leader>gb", function() builtin.git_branches() end) -- "Git Branches Telescope"

-- Vim internals
map("n", "<leader>vo", function() builtin.vim_options() end) -- "Vim Options Telescope"
map("n", "<leader>vc", function() builtin.commands() end) -- "Vim Commands Telescope"
map("n", "<leader>vk", function() builtin.keymaps() end) -- "Vim Keymaps Telescope"

-- Colorscheme
map("n", "<leader>th", function() builtin.colorscheme() end) -- "Find Colorscheme Telescope"
