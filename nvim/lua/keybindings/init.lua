
local function load_keybindings()
    -- Ottieni il path assoluto della directory del file chiamante
    local dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
    local handle = vim.loop.fs_scandir(dir)
    local excluded = {
        ["init.lua"] = true,
        ["blink.lua"] = true,
        ["telescope.lua"] = true,
        ["buffers.lua"] = true
    }

    while handle do
        local name, t = vim.loop.fs_scandir_next(handle)
        if not name then break end

        -- Carica solo i file .lua (esclude init.lua se presente)
        if (t == "file" or t == "link") and name:sub(-4) == ".lua" and not excluded[name] then
            local module_name = "keybindings." .. name:sub(1, -5) -- rimuove ".lua"
            local ok, module = pcall(require, module_name)
            if ok and module.setup then
                module.setup()
            else
                vim.notify("Errore nel caricare " .. module_name, vim.log.levels.ERROR)
            end
        end
    end
end

return {
    setup = load_keybindings
}
