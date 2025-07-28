return { 
    "nvim-telescope/telescope.nvim",
    opts = {
        defaults = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "-L" },
            vimgrep_arguments = {
                "rg", "--vimgrep", "--color=never", "--no-heading",
                "--with-filename", "--line-number", "--column",
                "--smart-case", "--hidden", "-L",
            },
        }
    },
    cmd = "Telescope",
    keys = function ()
        return require("keybindings.telescope").get_mappings()
    end,
    pickers = {
        find_files = { hidden = true },
    }
}

