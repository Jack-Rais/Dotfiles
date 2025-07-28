
local M = {}


function M.setup()
    vim.keymap.set("n", "<leader>fm",
        function()
            vim.lsp.buf.format { async = true }
        end,
        { desc = "LSP formatting" }
    )
end

return M
