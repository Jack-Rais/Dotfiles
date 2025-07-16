
local map = vim.keymap.set

-- nvim-tree
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })
map("n", "<leader>q", function()
    vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.winnr('#')), false)
end, { desc = "Close the previously focused window" })


