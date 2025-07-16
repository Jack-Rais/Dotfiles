return {
    "numToStr/Comment.nvim",
    keys = {
        { "cl", mode = "n",          desc = "Comment toggle current line" },
    },
    config = function(_, opts)
        opts.pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
        require("Comment").setup(opts)
    end,
}
