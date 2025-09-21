
local M = {}

function M.setup()
        
    local opts = { noremap = true, nowait = true, silent = true }

    vim.keymap.set("n", "<leader>to", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", opts)
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", opts)
    vim.keymap.set("n", "<C-ò>", "<cmd>ToggleTerm direction=horizontal<CR>", opts)

    vim.keymap.set("t", "<C-x>", "exit<CR>")

end

return M
