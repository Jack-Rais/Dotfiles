
local bufferline = require('bufferline')

bufferline.setup({
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
})
