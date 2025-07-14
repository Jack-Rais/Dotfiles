
-- Installare lazy.nvim se non è già presente nel systema
if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end


local lazy_config = require("configs.lazy")
require("lazy").setup({

    spec = {
        { import = "plugins" },
    }

}, lazy_config)



require("configs.options")

