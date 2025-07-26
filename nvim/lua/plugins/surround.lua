return {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            mappings = {
                add = "ys",      -- Aggiungi surround
                delete = "ds",   -- Elimina surround
                change = "cs",   -- Cambia surround
            },
            pairs = {
                ["f"] = { "function_name(", ")" },
                ["t"] = { "<tag>", "</tag>" },
            },
            aliases = {
                ["q"] = { "'", '"', "`" },
            },
            move_cursor = false,
        })
    end
}

