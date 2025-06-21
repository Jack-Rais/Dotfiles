
vim.cmd.colorscheme "catppuccin"
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'catppuccin/nvim', as = 'catpuccin'
	}
    use {
    	'nvim-treesitter/nvim-treesitter', 
    	branch = 'master',
    }
    use { 'neoclide/coc.nvim', branch = 'release' }
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            npairs.setup({})

            _G.confirm_with_autopairs = function()
                if vim.fn["coc#pum#visible"]() == 1 then
                    return vim.fn["coc#pum#confirm"]()
                else
                    return require("nvim-autopairs").autopairs_cr()
                end
            end

            vim.api.nvim_set_keymap("i", "<CR>", "v:lua.confirm_with_autopairs()", {
                expr = true,
                noremap = true,
                silent = true,
            })
        end,
    }

end)
