require "nvchad.options"

vim.o.cursorlineopt = 'both'

-- Inserire numeri delle righe, relativi e non
vim.opt.relativenumber = true
vim.opt.number = true

-- Impostare la minima distanza dalla fine del file
vim.opt.scrolloff = 8

-- Inserire le impostazioni per i tab
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Impostare quando le parentesi vengono chiuse
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Impostazione per i file md (tenere aperto il browser anche dopo aver chiuso il file)
vim.g.mkdp_auto_close = 0

-- Impostare i colori per la segnaletica delle modifiche di git 
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffaa00", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000", bg = "NONE" })


-- Aggiungere lo spellcheck per file markdown
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { 'en_us' }
    end,
    group = vim.api.nvim_create_augroup("SpellCheck", { clear = true })
})

-- Impostare la lunghezza dei tab nei file json
vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.bo.expandtab = true
        vim.bo.softtabstop = 2
    end,
    group = vim.api.nvim_create_augroup("2-space-indentation", { clear = true })
})

-- Impostare il testo nel codice ripiegato
vim.cmd [[ highlight Folded gui=italic ]]
