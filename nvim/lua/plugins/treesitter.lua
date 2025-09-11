return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "markdown",
            "markdown_inline",
            "python",
            "rust"
        },
        sync_install = false,
        auto_install = false,
        hightlight = { enable = true }
    },
    config = function ()
        vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg = '#f5e0dc'} )
    end
}

