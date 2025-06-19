
vim.cmd.colorscheme "catppuccin"
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'
	use 'rstacruz/vim-closer'
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
end)
