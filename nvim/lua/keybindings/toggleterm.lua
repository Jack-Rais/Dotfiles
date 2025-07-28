
local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>h", "<cmd> ToggleTerm direction=horizontal <CR>")
    vim.keymap.set("n", "<leader>v", "<cmd> ToggleTerm direction=vertical <CR>")

    vim.keymap.set("n", "<C-ò>", "<cmd> ToggleTerm direction=horizontal <CR>")

    vim.keymap.set("t", "<C-x>", "exit <CR>")
end

return M
