return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { light = "latte", dark = "mocha" },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
            },
            telescope = true,
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            notify = true,
            mini = true,
            harpoon = true,
        },
    },

    config = function()
        vim.cmd.colorscheme "catppuccin"
    end,
}

