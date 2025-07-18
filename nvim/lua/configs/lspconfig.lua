require("nvchad.configs.lspconfig").defaults()

local servers = { 
    "html", 
    "cssls",
    "pyright",
    "rust_analyzer",
    "qmlls"
}
vim.lsp.enable(servers)
