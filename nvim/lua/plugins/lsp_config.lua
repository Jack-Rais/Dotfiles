return {
    "neovim/nvim-lspconfig",
    config = function()

        

        local servers = {
            "lua_ls",
            "pyright",
            "rust-analyzer"
        }

        vim.lsp.enable(servers)
    end,
}
