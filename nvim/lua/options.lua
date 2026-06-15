-- ============================================================
-- OPTIONS
-- ============================================================

vim.o.cursorlineopt = "both"

vim.opt.shortmess:append("c")
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.fillchars:append({
    stl       = " ",
    eob       = " ",
    fold      = " ",
    foldopen  = " ",
    foldsep   = " ",
    foldclose = "",
    vert      = "▕",
    vertleft  = "▕",
})

local options = {
    -- Editing
    expandtab      = true,
    shiftwidth     = 4,
    tabstop        = 4,
    softtabstop    = 4,
    smartindent    = true,
    conceallevel   = 2,
    concealcursor  = "",

    -- Search
    ignorecase     = true,
    smartcase      = true,

    -- UI
    number         = true,
    relativenumber = true,
    cursorline     = false,
    signcolumn     = "yes:2",
    scrolloff      = 8,
    cmdheight      = 0,
    laststatus     = 3,
    showtabline    = 2,
    pumheight      = 10,
    termguicolors  = true,
    showmode       = false,
    wrap           = false,
    emoji          = false,

    -- Completion
    completeopt    = "menu,menuone,preview",

    -- Folding
    foldcolumn     = "0",
    foldnestmax    = 0,
    foldlevel      = 99,
    foldlevelstart = 99,

    -- Files & backup
    swapfile       = false,
    writebackup    = false,
    undofile       = true,
    fileencoding   = "utf-8",

    -- Misc
    clipboard      = "unnamed,unnamedplus",
    mouse          = "a",
    splitright     = true,
    timeoutlen     = 200,
    updatetime     = 100,
    wildignore     = "*node_modules/**",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end


-- ============================================================
-- APPEARANCE
-- ============================================================

vim.api.nvim_set_hl(0, "GitSignsAdd",           { fg = "#00ff00", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsChange",        { fg = "#ffaa00", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsDelete",        { fg = "#ff0000", bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { underline = false })


-- ============================================================
-- TREESITTER
-- ============================================================

-- Remove treesitter indentation and use the flutter one
vim.api.nvim_create_autocmd("FileType", {
    pattern = "dart",
    callback = function()
        vim.bo.indentexpr = ""
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)

        if vim.bo[args.buf].filetype == "dart" then
            vim.keymap.set({ "n", "v" }, "=", function()
                vim.lsp.buf.format({ bufnr = args.buf, async = false })
            end, { buffer = args.buf })
        end

    end,
})

-- ============================================================
-- LSP
-- ============================================================

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

vim.lsp.enable('kotlin_lsp')
vim.lsp.config('kotlin_lsp', {
    cmd       = { 'kotlin-lsp' },
    filetypes = { 'kotlin', 'java', 'swift' },
    root_markers = {
        'build.gradle', 'build.gradle.kts', 'pom.xml', 'settings.gradle', 'Package.swift', '.git'
    },
    settings  = {},
})

vim.lsp.enable('dart')
vim.lsp.config('dart', {
    cmd       = { 'dart', "language-server", "--protocol=lsp" },
    filetypes = { 'dart' },
    root_markers = {
        'pubspec.yml', '.git'
    },
    settings  = {},
})


-- ============================================================
-- DIAGNOSTICS
-- ============================================================

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    float = {
        border = "rounded",
    }
})


-- ============================================================
-- AUTOCOMMANDS
-- ============================================================

vim.api.nvim_create_autocmd("FileType", {
    group   = vim.api.nvim_create_augroup("markdown_settings", { clear = true }),
    pattern = { "markdown", "text" },
    callback = function()
        vim.opt_local.spell       = true
        vim.opt_local.spelllang   = { "en_us", "it" }
        vim.opt_local.wrap        = true
        vim.opt_local.linebreak   = true
        vim.opt_local.breakindent = true

        local opts = { buffer = true }
        vim.keymap.set("n", "j", "gj", opts)
        vim.keymap.set("n", "k", "gk", opts)
        vim.keymap.set("n", "0", "g0", opts)
        vim.keymap.set("n", "$", "g$", opts)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group   = vim.api.nvim_create_augroup("two_space_indent", { clear = true }),
    pattern = { "json", "html", "htmldjango" },
    callback = function()
        vim.bo.shiftwidth   = 2
        vim.bo.tabstop      = 2
        vim.bo.softtabstop  = 2
    end,
})
