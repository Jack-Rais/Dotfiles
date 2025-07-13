


local lazy_config = require("configs.lazy")
require("lazy").setup({

    spec = {
        { import = "plugins" },
    }

}, lazy_config)



require("configs.options")

