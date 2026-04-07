return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()

        local function natural_cmp(left, right)
            local specials = {
                ["__init__.py"] = true,
                ["mod.rs"] = true,
                ["init.lua"] = true
            }

            local dotl = left.name:sub(1, 1) == "."
            local dotr = right.name:sub(1, 1) == "."

            -- Dirs before files
            if left.type == right.type then
                if dotl and not dotr then
                    return true
                elseif dotr and not dotl then
                    return false
                end
            else
                if left.type == "directory" then
                    return true
                else
                    return false
                end
            end

            if specials[left.name] and not specials[right.name] then
                return true
            elseif specials[right.name] and not specials[left.name] then
                return false
            end

            local l, r = left.name:lower(), right.name:lower()

            if l == r then
                return false
            end

            local i, j = 1, 1
            while i <= #l and j <= #r do
                local li = l:sub(i, i)
                local ri = r:sub(j, j)

                if li:match("%d") and ri:match("%d") then
                    local lnum = tonumber(l:match("%d+", i))
                    local rnum = tonumber(r:match("%d+", j))

                    if lnum ~= rnum then
                        return lnum < rnum
                    end

                    i = i + #tostring(lnum)
                    j = j + #tostring(rnum)
                elseif li ~= ri then
                    return li < ri
                else
                    i, j = i + 1, j + 1
                end
            end

            return #l < #r
        end

        vim.cmd [[
          :hi NvimTreeGitDirtyIcon guifg=#ffaa00
          :hi NvimTreeGitStagedIcon guifg=#ffaa00
          :hi NvimTreeGitDeletedIcon guifg=#ff0000
          :hi NvimTreeGitMergeIcon guifg=#00ffff
          :hi NvimTreeGitNewIcon guifg=#00ff00
          :hi NvimTreeGitIgnoredIcon guifg=#888888
          :hi VertSplit cterm=NONE ctermfg=NONE ctermbg=NONE
        ]]

        require("nvim-tree").setup({
            git = {
                enable = true,
                ignore = false,
                show_on_dirs = true,
                timeout = 400,
            },

            sort = {
                sorter = function(nodes)
                    table.sort(nodes, natural_cmp)
                end
            },

            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },

            view = {
                adaptive_size = false,
                width = 30,
                side = "left",
                number = false,
                relativenumber = false,
                signcolumn = "yes",
            },

            renderer = {
                add_trailing = false,
                group_empty = true,
                highlight_git = true,
                special_files = { "README.md", "Makefile", "Cargo.toml" },

                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└ ",
                        edge   = "│ ",
                        item   = "│ ",
                    },
                },

                icons = {
                    webdev_colors = true,
                    git_placement = "after",
                    show = {
                        file   = true,
                        folder = true,
                        git    = true,
                    },
                },
            },

            hijack_directories = {
                enable = true,
                auto_open = true,
            },

            update_focused_file = {
                enable = true,
                update_root = true,
            },

            filters = {
                dotfiles = false,
                custom = { ".DS_Store" },
            },

            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                local function opts(desc)
                    return {
                        desc = "nvim-tree: " .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true,
                    }
                end

                api.config.mappings.default_on_attach(bufnr)

                vim.keymap.set("n", "<leader>o", function()
                    api.node.open.edit()
                    api.tree.close()
                end, opts("Open file and close tree"))

                vim.keymap.set("n", "<leader>q", function()
                    vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
                end, opts("Close focused window"))
            end,
        })
    end,
}
