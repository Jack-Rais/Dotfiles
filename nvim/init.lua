require("user")


vim.cmd.colorscheme "catppuccin"

vim.o.expandtab = true -- expand tab input with spaces characters
vim.o.smartindent = true -- syntax aware indentations for newline inserts
vim.o.tabstop = 4 -- num of space characters per tab
vim.o.shiftwidth = 4 -- spaces per indentation level

vim.opt.number = true
vim.opt.relativenumber = true


vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "LineNrRelative", { fg = "#00FF00" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FF0000", bold = true })


vim.diagnostic.config({
    virtual_text = true,  -- mostra errore inline
    signs = true,         -- mostra segni in gutter
    underline = true,
    update_in_insert = false,
})

vim.g.coc_global_extensions = {
    'coc-pyright',
    'coc-rust-analyzer'
}
