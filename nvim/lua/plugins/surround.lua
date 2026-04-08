require("nvim-surround").setup({
    mappings = {
        add = "ys",
        delete = "ds",
        change = "cs",
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
