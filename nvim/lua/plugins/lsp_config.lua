return {
    "neovim/nvim-lspconfig",
    config = function()

        -- local servers = {
        --     "lua_ls",
        --     "pyright",
        --     "rust_analyzer"
        -- }
        --
        -- vim.lsp.enable(servers)

        vim.lsp.config('*', {
            capabilities = {
                textDocument = {
                    semanticTokens = {
                        multilineTokenSupport = true,
                    }
                }
            }
        })

    end,
}
