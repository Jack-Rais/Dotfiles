return {
    'nvim-treesitter/nvim-treesitter',
    -- lazy = false,
    build = ':TSUpdate',
    event = "BufReadPre",

    config = function ()

        local languages = {
            'rust',
            'python',
            'bash',
            'html',
            'css',
            'javascript'
        }

        require('nvim-treesitter').install(languages)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = '*',
            callback = function(ev)

                local language_name = vim.treesitter.language.get_lang(ev.match)

                if pcall(vim.treesitter.language.inspect, language_name) then
                    vim.treesitter.start(ev.buf)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end

            end
        })

    end
}
