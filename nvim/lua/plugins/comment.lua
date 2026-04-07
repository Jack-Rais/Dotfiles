
return {
    "numToStr/Comment.nvim",

    config = function()

        local opts = { noremap = true, silent = true }

        vim.keymap.set({ "n", "v" }, "<leader>cb", "<Cmd>CBccbox<CR>", opts)
        vim.keymap.set("n", "<leader>cl", "<Cmd>CBline<CR>", opts)

    end
}
