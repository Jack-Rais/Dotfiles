
local M = {}

function M.setup()
        
    local opts = { noremap = true, nowait = true, silent = true }

    vim.keymap.set("n", "<leader>h", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
    vim.keymap.set("n", "<leader>v", "<cmd>ToggleTerm direction=vertical<CR>", opts)
    vim.keymap.set("n", "<C-ò>", "<cmd>ToggleTerm direction=horizontal<CR>", opts)

    vim.keymap.set("t", "<C-x>", "exit<CR>")

end

return M
