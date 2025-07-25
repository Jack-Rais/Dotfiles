return {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
        size = function(term)
			if term.direction == "horizontal" then
				return vim.o.lines * 0.30
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.40
			end
		end
    }
}
