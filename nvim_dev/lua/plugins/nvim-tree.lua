return {
    "nvim-tree/nvim-tree.lua",
    opts = function()

        vim.cmd [[
            :hi NvimTreeGitDirty guifg=#ffaa00
            :hi NvimTreeGitStaged guifg=#ffaa00
            :hi NvimTreeGitDeleted guifg=#ff0000
            :hi NvimTreeGitMerge guifg=#00ffff
            :hi NvimTreeGitNew guifg=#00ff00
            :hi NvimTreeGitIgnored guifg=#888888
        ]]

        return {
            git = { ignore = false },
            on_attach = function(bufnr)

                local api = require("nvim-tree.api")
                
                local function opts(desc)
                    return {
                        desc = "nvim-tree" .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true
                    }
                end

                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set( 'n', '<leader>o', function()
                    api.node.open.edit()
                    api.tree.close()
                end, opts("Open file and close file tree"))

            end
        }
        
    end, 
}
