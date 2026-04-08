require('nvim-treesitter').setup()

local ensure_installed = {
    'lua',
    'rust',
    'python',
    'bash',
    'html',
    'css',
    'javascript'
}

local already_installed = require('nvim-treesitter.config').get_installed()
local parsers_to_install = vim.iter(ensure_installed)
    :filter(function(parser)
        return not vim.tbl_contains(already_installed, parser)
    end)
    :totable()

require('nvim-treesitter').install(parsers_to_install)


vim.api.nvim_create_autocmd("FileType", {
    pattern = '*',
    callback = function(ev)

        local language_name = vim.treesitter.language.get_lang(ev.match)

        if pcall(vim.treesitter.language.inspect, language_name) then
            vim.treesitter.start(ev.buf)
        end

    end
})
