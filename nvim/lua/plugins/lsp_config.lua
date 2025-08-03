return {
    "neovim/nvim-lspconfig",
    config = function()

        local servers = {
            "lua_ls",
            "pyright",
        }

        vim.lsp.enable(servers)
    end,
}
