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
        vim.api.nvim_set_hl(0, '@lsp.type.typeAlias.rust', { link = '@lsp.type.interface'} )
        vim.api.nvim_set_hl(0, '@lsp.type.variable', { link = '@lsp.type.parameter'} )
        vim.api.nvim_set_hl(0, '@lsp.type.const.rust', { link = '@lsp.type.parameter'} )
    end
}

