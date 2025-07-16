return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = { 
        ensure_installed = { 
            "html", 
            "css", 
            "javascript", 
            "tsx", 
            "typescript", 
            "json", 
            "cpp", 
            "rust", 
            "markdown", 
            "python" 
        },
        sync_install = false,
        auto_install = false,
    },
}
