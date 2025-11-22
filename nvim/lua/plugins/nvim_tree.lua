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
            :hi VertSplit cterm=NONE ctermfg=NONE ctermbg=NONE
        ]]

        local icons = {
            diagnostics = require("utils.icons").get("diagnostics"),
            documents = require("utils.icons").get("documents"),
            git = require("utils.icons").get("git"),
            ui = require("utils.icons").get("ui"),
        }

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

            -- If one is special it comes first
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
                local li = l:sub(i, i)  -- Correzione: ho scambiato li e ri
                local ri = r:sub(j, j)

                if li:match("%d") and ri:match("%d") then
                    local lnum = tonumber(l:match("%d+", i))
                    local rnum = tonumber(r:match("%d+", j))

                    if lnum ~= rnum then
                        return lnum < rnum  -- Correzione: per ordine crescente
                    end

                    i = i + #tostring(lnum)
                    j = j + #tostring(rnum)
                elseif li ~= ri then
                    return li < ri  -- Correzione: per ordine crescente
                else
                    i, j = i + 1, j + 1
                end
            end

            -- Return finale FUORI dal ciclo while
            return #l < #r
        end

        return {

            git = {
                enable = true,
                ignore = false,
                show_on_dirs = true,
                timeout = 400,
            },

            sort = {
                sorter = function (nodes)
                    table.sort(nodes, natural_cmp)
                end
            },

            actions = {
                open_file = {
                    quit_on_open = true
                }
            },

            view = {
                adaptive_size = false,
                centralize_selection = false,
                width = 30,
                side = "left",
                preserve_window_proportions = false,
                number = false,
                relativenumber = false,
                signcolumn = "yes",
                float = {
                    enable = false,
                    open_win_config = {
                        relative = "editor",
                        border = "rounded",
                        width = 30,
                        height = 30,
                        row = 1,
                        col = 1,
                    },
                },
            },

            renderer = {
                add_trailing = false,
                group_empty = true,
                highlight_git = true,
                full_name = false,
                highlight_opened_files = "none",
                special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
                symlink_destination = true,
                indent_markers = {
                    enable = true,
                    icons = {
                        corner = "└ ",
                        edge = "│ ",
                        item = "│ ",
                        none = "  ",
                    },
                },
                root_folder_label = ":.:s?.*?/..?",
                icons = {
                    webdev_colors = true,
                    git_placement = "after",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                    padding = " ",
                    symlink_arrow = " 󰁔 ",
                    glyphs = {
                        default = icons.documents.Default, --
                        symlink = icons.documents.Symlink, --
                        bookmark = icons.ui.Bookmark,
                        git = {
                            unstaged = icons.git.Mod_alt,
                            staged = icons.git.Add, --󰄬
                            unmerged = icons.git.Unmerged,
                            renamed = icons.git.Rename, --󰁔
                            untracked = icons.git.Untracked, -- "󰞋"
                            deleted = icons.git.Remove, --
                            ignored = icons.git.Ignore, --◌
                        },
                        folder = {
                            arrow_open = icons.ui.ArrowOpen,
                            arrow_closed = icons.ui.ArrowClosed,
                            -- arrow_open = "",
                            -- arrow_closed = "",
                            default = icons.ui.Folder,
                            open = icons.ui.FolderOpen,
                            empty = icons.ui.EmptyFolder,
                            empty_open = icons.ui.EmptyFolderOpen,
                            symlink = icons.ui.SymlinkFolder,
                            symlink_open = icons.ui.FolderOpen,
                        },
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
                ignore_list = {},
            },

            filters = {
                dotfiles = false,
                custom = { ".DS_Store" },
                exclude = {},
            },

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
                local map = vim.keymap.set

                map( 'n', '<leader>o', function()
                    api.node.open.edit()
                    api.tree.close()
                end, opts("Open file and close file tree"))

                map("n", "<leader>q", function()
                    vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.winnr('#')), false)
                end, { desc = "Close the previously focused window" })
            end
        }
    end,
}




-- return {
--     "nvim-tree/nvim-tree.lua",
--     opts = function()
--
--         vim.cmd [[
--             :hi NvimTreeGitDirty guifg=#ffaa00
--             :hi NvimTreeGitStaged guifg=#ffaa00
--             :hi NvimTreeGitDeleted guifg=#ff0000
--             :hi NvimTreeGitMerge guifg=#00ffff
--             :hi NvimTreeGitNew guifg=#00ff00
--             :hi NvimTreeGitIgnored guifg=#888888
--             :hi VertSplit cterm=NONE ctermfg=NONE ctermbg=NONE
--         ]]
--
--         local icons = {
--             diagnostics = require("utils.icons").get("diagnostics"),
--             documents = require("utils.icons").get("documents"),
--             git = require("utils.icons").get("git"),
--             ui = require("utils.icons").get("ui"),
--         }
--
--         local function natural_cmp(left, right)
--
--             local specials = {
--                 ["__init__.py"] = true,
--                 ["mod.rs"] = true,
--                 ["init.lua"] = true
--             }
--
--             local dotl = left.name:sub(1, 1) == "."
--             local dotr = right.name:sub(1, 1) == "."
--
--             -- Dirs before files
--             if left.type == right.type then
--
--                 if dotl and not dotr then
--                     return true
--
--                 elseif dotr and not dotl then
--                     return false
--
--                 end
--
--             else
--
--                 if left.type == "directory" then
--                     return true
--
--                 else
--                     return false
--
--                 end
--
--             end
--
--             -- If one is special it comes first
--             if specials[left.name] and not specials[right.name] then
--                 return true
--
--             elseif specials[right.name] and not specials[left.name] then
--                 return false
--
--             end
--
--             local l, r = left.name:lower(), right.name:lower()
--
--             if l == r then
--                 return false
--             end
--
--             local i, j = 1, 1
--             while i <= #l and j <= #r do
--
--                 local ri, li = l:sub(i, i), r:sub(j, j)
--
--                 if li:match("%d") and ri:match("%d") then
--                     local lnum = tonumber(l:match("%d+", i))
--                     local rnum = tonumber(r:match("%d+", j))
--
--                     if lnum ~= rnum then
--                         return lnum > rnum
--                     end
--
--                     i = i + #tostring(lnum)
--                     j = j + #tostring(rnum)
--
--                 elseif li ~= ri then
--                     return li > ri
--
--                 else
--                     i, j = i + 1, j + 1
--
--                 end
--
--                 return #l < #r
--
--             end
--
--
--         end
--
--         return {
--
--             git = {
--                 enable = true,
--                 ignore = false,
--                 show_on_dirs = true,
--                 timeout = 400,
--             },
--
--             sort = {
--                 sorter = function (nodes)
--                     table.sort(nodes, natural_cmp)
--                 end
--             },
--
--             actions = {
--                 open_file = {
--                     quit_on_open = true
--                 }
--             },
--
--             view = {
--                 adaptive_size = false,
--                 centralize_selection = false,
--                 width = 30,
--                 side = "left",
--                 preserve_window_proportions = false,
--                 number = false,
--                 relativenumber = false,
--                 signcolumn = "yes",
--                 float = {
--                     enable = false,
--                     open_win_config = {
--                         relative = "editor",
--                         border = "rounded",
--                         width = 30,
--                         height = 30,
--                         row = 1,
--                         col = 1,
--                     },
--                 },
--             },
--
--             renderer = {
--                 add_trailing = false,
--                 group_empty = true,
--                 highlight_git = true,
--                 full_name = false,
--                 highlight_opened_files = "none",
--                 special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
--                 symlink_destination = true,
--                 indent_markers = {
--                     enable = true,
--                     icons = {
--                         corner = "└ ",
--                         edge = "│ ",
--                         item = "│ ",
--                         none = "  ",
--                     },
--                 },
--                 root_folder_label = ":.:s?.*?/..?",
--                 icons = {
--                     webdev_colors = true,
--                     git_placement = "after",
--                     show = {
--                         file = true,
--                         folder = true,
--                         folder_arrow = true,
--                         git = true,
--                     },
--                     padding = " ",
--                     symlink_arrow = " 󰁔 ",
--                     glyphs = {
--                         default = icons.documents.Default, --
--                         symlink = icons.documents.Symlink, --
--                         bookmark = icons.ui.Bookmark,
--                         git = {
--                             unstaged = icons.git.Mod_alt,
--                             staged = icons.git.Add, --󰄬
--                             unmerged = icons.git.Unmerged,
--                             renamed = icons.git.Rename, --󰁔
--                             untracked = icons.git.Untracked, -- "󰞋"
--                             deleted = icons.git.Remove, --
--                             ignored = icons.git.Ignore, --◌
--                         },
--                         folder = {
--                             arrow_open = icons.ui.ArrowOpen,
--                             arrow_closed = icons.ui.ArrowClosed,
--                             -- arrow_open = "",
--                             -- arrow_closed = "",
--                             default = icons.ui.Folder,
--                             open = icons.ui.FolderOpen,
--                             empty = icons.ui.EmptyFolder,
--                             empty_open = icons.ui.EmptyFolderOpen,
--                             symlink = icons.ui.SymlinkFolder,
--                             symlink_open = icons.ui.FolderOpen,
--                         },
--                     },
--                 },
--             },
--
--             hijack_directories = {
--                 enable = true,
--                 auto_open = true,
--             },
--
--             update_focused_file = {
--                 enable = true,
--                 update_root = true,
--                 ignore_list = {},
--             },
--
--             filters = {
--                 dotfiles = false,
--                 custom = { ".DS_Store" },
--                 exclude = {},
--             },
--
--             on_attach = function(bufnr)
--
--                 local api = require("nvim-tree.api")
--
--                 local function opts(desc)
--                     return {
--                         desc = "nvim-tree" .. desc,
--                         buffer = bufnr,
--                         noremap = true,
--                         silent = true,
--                         nowait = true
--                     }
--                 end
--
--                 api.config.mappings.default_on_attach(bufnr)
--                 local map = vim.keymap.set
--
--                 map( 'n', '<leader>o', function()
--                     api.node.open.edit()
--                     api.tree.close()
--                 end, opts("Open file and close file tree"))
--
--
--                 map("n", "<leader>q", function()
--                     vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.winnr('#')), false)
--                 end, { desc = "Close the previously focused window" })
--
--             end
--         }
--
--     end,
-- }
--
