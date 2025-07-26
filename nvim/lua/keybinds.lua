local map = vim.keymap.set


-- nvim-tree
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })


-- toggleterm
map("n", "<leader>h", "<cmd> ToggleTerm direction=horizontal <CR>")
map("n", "<leader>v", "<cmd> ToggleTerm direction=vertical <CR>")

map("n", "<C-ò>", "<cmd> ToggleTerm direction=horizontal <CR>")

map("t", "<C-x>", "exit <CR>")


-- Esecutori del file
-- Associa le scorciatoie nel file executors a tutti i linguaggi installati 

vim.api.nvim_create_augroup("executeFile", { clear = true })
for lang, keymap in pairs(require('executors')) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lang,
        callback = keymap,
        group = "executeFile"
    })
end


-- Comment
map("n", "<leader>/",
    function()
        require("Comment.api").toggle.linewise.current()
    end,
    { desc = "Toggle comment" })

map("v", "<leader>/",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" }
)


-- Jump to errors and locations
map("n", "<leader>k", "<cmd>cprev<CR><cmd>cclose<CR>", { desc = "Jump prev of quick fix list", silent = true })
map("n", "<leader>j", "<cmd>cnext<CR><cmd>cclose<CR>", { desc = "Jump next of quick fix list", silent = true })
map("n", "<leader>K", "<cmd>lprev<CR><cmd>lclose<CR>", { desc = "Jump prev of location list", silent = true })
map("n", "<leader>J", "<cmd>lnext<CR><cmd>lclose<CR>", { desc = "Jump next of location list", silent = true })


-- Indentation
map("n", "<", "<gv", { desc = "Indent line" })
map("n", ">", ">gv", { desc = "Indent line" })


-- navigate within insert mode
map('i', "<C-h>", "<Left>", { desc = "Move left" })
map('i', "<C-l>", "<Right>", { desc = "Move right" })
map('i', "<C-j>", "<Down>", { desc = "Move down" })
map('i', "<C-k>", "<Up>", { desc = "Move up" })

map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })


-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })


map("n", "<leader>fm",
    function()
        vim.lsp.buf.format { async = true }
    end,
    { desc = "LSP formatting" }
)




map("x", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("x", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })


-- Don't copy the replaced text after pasting in visual mode
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })


-- Copiare il testo in clipboard
map("v", "<C-y>", "\"+y")


-- Se eseguito, aspetta il carattere dopo e lo esegue senza aspettare l'invio 
map("n", "<leader>;", function()
    local char = vim.fn.getcharstr()
    return '<cmd>' .. char .. '<CR>'
end, { expr = true, desc = "1 char CMD" })
