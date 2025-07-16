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
                ["f"] = { "function_name(", ")" }, -- Esempio di coppia personalizzata
                ["t"] = { "<tag>", "</tag>" },     -- Esempio di coppia personalizzata
            },
            aliases = {
                ["q"] = { "'", '"', "`" },         -- Alias per i delimitatori
            },
            move_cursor = false,                 -- Impedisce al cursore di spostarsi dopo l'operazione
        })
    end
}
