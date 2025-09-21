
local M = {}

function M.setup()
    vim.keymap.set("n", "<leader>sl", "<cmd>:Lazy<cr>")
end

return M


