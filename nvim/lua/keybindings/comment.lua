

local M = {}


function M.setup()
    vim.keymap.set("n", "<leader>/",
    function()
        require("Comment.api").toggle.linewise.current()
    end,
    { desc = "Toggle comment" })

    vim.keymap.set("v", "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" })


    local opts = { noremap = true, silent = true }

    vim.keymap.set({ "n", "v" }, "<leader>cb", "<Cmd>CBccbox<CR>", opts)
    vim.keymap.set("n", "<leader>cl", "<Cmd>CBline<CR>", opts)
    
end

return M
