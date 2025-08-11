return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "pyright",
            "lua_ls",
            "rust_analyzer",
            "zls"
        }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
