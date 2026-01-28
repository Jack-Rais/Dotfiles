return {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000, -- Importante: assicura il caricamento prima
    config = function()

        require("onedarkpro").setup({
            styles = {
                keywords = "bold,italic", -- Stile per le keyword
                comments = "italic",
                functions = "bold",
                strings = "NONE",
                variables = "NONE"
            },
            -- Altri settaggi opzionali
            options = {
                terminal_colors = true,
                cursorline = true,
                transparency = false
            }
        })

        -- DOPO il setup, carica il colorscheme
        vim.cmd.colorscheme("onedark")

    end,
}
