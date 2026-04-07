return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function ()

        local bufferline = require("bufferline")

        bufferline.setup {
            options = {

                show_buffer_close_icons = false,
                separator_style = { "", "" },
                always_show_bufferline = true,
                style_preset = bufferline.style_preset.no_italic,

                numbers = function(opts)
                    return string.format("%s", opts.ordinal)
                end,

                offsets = {
                    {
                        filetype = "snacks_layout_box",
                        text = "",
                        highlight = "EcovimNvimTreeTitle",
                        text_align = "center",
                        separator = false,
                    },
                },
            }
        }
    end,

    keys = {
        { "<C-k>",       "<cmd>BufferLineCycleNext<CR>",               mode = "n", desc = "Cycle Forward" },
        { "<C-j>",       "<cmd>BufferLineCyclePrev<CR>",               mode = "n", desc = "Cycle Backward" },
        { "<C-BS>",      "<cmd>bdelete<CR>",                           desc = "Delete current buffer" },
        { "<leader>bb",  "<cmd>BufferLineMovePrev<CR>",                desc = "Move back" },
        { "<leader>bn",  "<cmd>BufferLineMoveNext<CR>",                desc = "Move next" },
    }

}
