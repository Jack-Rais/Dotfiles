
local M = {}

function M.setup()

    local map = vim.keymap.set

    vim.api.nvim_create_augroup("executeFile", { clear = true })
    for lang, keymap in pairs(require('executors')) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = lang,
            callback = keymap,
            group = "executeFile"
        })
    end

    -- Jump to errors and locations
    map("n", "<leader>k", "<cmd>cprev<CR><cmd>cclose<CR>", { silent = true })
    map("n", "<leader>j", "<cmd>cnext<CR><cmd>cclose<CR>", { silent = true })
    map("n", "<leader>K", "<cmd>lprev<CR><cmd>lclose<CR>", { silent = true })
    map("n", "<leader>J", "<cmd>lnext<CR><cmd>lclose<CR>", { silent = true })


    -- Indentation
    map('v', '>', '>gv', { noremap = true })
    map('v', '<', '<gv', { noremap = true })
    map('n', '>', '>>', { noremap = true })
    map('n', '<', '<<', { noremap = true })


    -- navigate within insert mode
    map('i', "<C-h>", "<Left>", { desc = "Move left" })
    map('i', "<C-l>", "<Right>", { desc = "Move right" })
    map('i', "<C-j>", "<Down>", { desc = "Move down" })
    map('i', "<C-k>", "<Up>", { desc = "Move up" })

    map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

    -- Don't copy the replaced text after pasting in visual mode
    map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })


    -- Copiare il testo in clipboard
    map("v", "<C-y>", "\"+y")


    -- Se eseguito, aspetta il carattere dopo e lo esegue senza aspettare l'invio 
    map("n", "<leader>;", function()
        local char = vim.fn.getcharstr()
        return '<cmd>' .. char .. '<CR>'
    end, { expr = true, desc = "1 char CMD" })

    -- Aprire la diagnostica in una float window
    vim.keymap.set('n', '<leader>d', function()
        vim.diagnostic.open_float(nil, { scope = 'line' })
    end, { noremap = true, silent = true})


end

return M
