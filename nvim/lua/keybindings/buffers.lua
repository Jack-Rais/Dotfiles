
local M = {}


function M.get_mappings()

    return {
      { "<A-1>",       "<cmd>BufferLineGoToBuffer 1<CR>" },
      { "<A-2>",       "<cmd>BufferLineGoToBuffer 2<CR>" },
      { "<A-3>",       "<cmd>BufferLineGoToBuffer 3<CR>" },
      { "<A-4>",       "<cmd>BufferLineGoToBuffer 4<CR>" },
      { "<A-5>",       "<cmd>BufferLineGoToBuffer 5<CR>" },
      { "<A-6>",       "<cmd>BufferLineGoToBuffer 6<CR>" },
      { "<A-7>",       "<cmd>BufferLineGoToBuffer 7<CR>" },
      { "<A-8>",       "<cmd>BufferLineGoToBuffer 8<CR>" },
      { "<A-9>",       "<cmd>BufferLineGoToBuffer 9<CR>" },
      { "<A-k>",  "<cmd>BufferLineCycleNext<CR>",               desc = "Cycle Forward" },
      { "<A-j>",  "<cmd>BufferLineCyclePrev<CR>",               desc = "Cycle Backward" },
      { "<C-BS>", "<cmd>bdelete<CR>",                           desc = "Delete current buffer" },
      { "<leader>bB",  "<cmd>BufferLineMovePrev<CR>",                desc = "Move back" },
      { "<leader>bN",  "<cmd>BufferLineMoveNext<CR>",                desc = "Move next" },
      { "<leader>bp",  "<cmd>BufferLineTogglePin<CR>",               desc = "Pin/Unpin Buffer" },
    }

end

return M
