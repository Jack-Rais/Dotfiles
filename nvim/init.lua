require("user")
require("user.lsp")


vim.cmd.colorscheme "vscode"

vim.api.nvim_set_hl(0, "LineNr", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "LineNrRelative", { fg = "#00FF00" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FF0000", bold = true })


vim.diagnostic.config({
   virtual_text = true,  -- mostra errore inline
   signs = true,         -- mostra segni in gutter
   underline = true,
   update_in_insert = false,
})

