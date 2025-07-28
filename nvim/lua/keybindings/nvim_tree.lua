
local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })    
end

return M
