-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     lazy = false,
--     opts = {
--         flavour = "mocha", -- latte, frappe, macchiato, mocha
--         background = { light = "latte", dark = "mocha" },
--         integrations = {
--             treesitter = true,
--             native_lsp = {
--                 enabled = true,
--             },
--             telescope = true,
--             cmp = true,
--             gitsigns = true,
--             nvimtree = true,
--             notify = true,
--             mini = true,
--             harpoon = true,
--         },
--     },
--
--     config = function()
--         vim.cmd.colorscheme "catppuccin"
--     end,
-- }

return {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('onedark').setup {
            style = 'dark'
        }
        -- Enable theme
        require('onedark').load()
    end
}


