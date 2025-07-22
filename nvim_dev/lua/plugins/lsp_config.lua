return {
    "neovim/nvim-lspconfig",
    config = function()

        

        local servers = {
            "lua_ls",
            { "pyright", {
                    settings = {}
                }
            },
            "rust_analyzer",
            "qmlls"
        }

        vim.lsp.enable(servers)
    end,
}
