
local function load_keybindings()

    local keybinding_files = {
        "general",
        "lsp",
        "nvim_tree",
        "buffers",
        "comment",
        "toggleterm"
    }

    for _, file in ipairs(keybinding_files) do
        local ok, module = pcall(require, "keybindings." .. file)
        if ok and module.setup then
            module.setup()
        else
            vim.notify("Errore nel caricare keybindings." .. file, vim.log.levels.ERROR)
        end
    end

end

return {
    setup = load_keybindings
}

