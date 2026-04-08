
require("onedarkpro").setup({

    styles = {
        keywords = "bold,italic",
        comments = "italic",
        functions = "bold",
        strings = "NONE",
        variables = "NONE"
    },

    options = {
        terminal_colors = true,
        cursorline = true,
        transparency = false
    }

})


vim.cmd.colorscheme("onedark")
