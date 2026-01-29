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

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then
                    -- Disattiva semantic highlighting
                    client.server_capabilities.semanticTokensProvider = nil
                end
            end,
        })


    end,
}
