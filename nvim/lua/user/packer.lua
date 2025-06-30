

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
    use 'Mofiqul/vscode.nvim'
    use {
    	'nvim-treesitter/nvim-treesitter', 
    	branch = 'master',
    }
    use {
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
                map_cr = true
            }
        end
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua', -- utile per configurazioni Lua
            'L3MON4D3/LuaSnip',       -- snippet engine
            'saadparwaiz1/cmp_luasnip',
        }
    }
    use { 'mbbill/undotree' }
end)
