-- ============================================================
-- Keymaps
-- ============================================================

local map = vim.keymap.set

local opts       = { noremap = true, nowait = true, silent = true }
local silent     = { silent = true }
local noremap    = { noremap = true }
local ns         = { noremap = true, silent = true }

-- ============================================================
-- Disabled keys
-- ============================================================

map("n", ".", "<Nop>", ns)
map("n", "£", "<Nop>", ns)

-- ============================================================
-- UI / Tools
-- ============================================================

map("n", "<leader>e",  "<cmd>NvimTreeFocus<CR>",          opts)
map("n", "<leader>gd", "<cmd>CodeDiff<CR>",               opts)
map("n", "<Esc>",      "<cmd>noh<CR>",                    { desc = "Clear highlights" })
map("n", "<leader>d",  function()
  vim.diagnostic.open_float(nil, { scope = "line" })
end, { noremap = true, silent = true, desc = "Open line diagnostic" })

-- ============================================================
-- Terminal
-- ============================================================

map("n", "<leader>to", "<cmd>ToggleTerm direction=horizontal<CR>", opts)
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   opts)
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",      opts)
map("n", "<C-ò>",      "<cmd>ToggleTerm direction=horizontal<CR>", opts)
map("t", "<C-x>",      "exit<CR>")

-- ============================================================
-- Quickfix / Location list navigation
-- ============================================================

map("n", "<leader>j", "<cmd>cnext<CR><cmd>cclose<CR>", silent)
map("n", "<leader>k", "<cmd>cprev<CR><cmd>cclose<CR>", silent)
map("n", "<leader>J", "<cmd>lnext<CR><cmd>lclose<CR>", silent)
map("n", "<leader>K", "<cmd>lprev<CR><cmd>lclose<CR>", silent)

-- ============================================================
-- Indentation
-- ============================================================

map("v", ">", ">gv", noremap)
map("v", "<", "<gv", noremap)
map("n", ">", ">>",  noremap)
map("n", "<", "<<",  noremap)

-- ============================================================
-- Insert mode navigation
-- ============================================================

map("i", "<C-h>", "<Left>",  { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>",  { desc = "Move down" })
map("i", "<C-k>", "<Up>",    { desc = "Move up" })

-- ============================================================
-- Clipboard / Yank
-- ============================================================

-- Don't overwrite register when pasting over selection
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { silent = true, desc = "Paste without overwriting register" })
-- Copy selection to system clipboard
map("v", "<C-y>", '"+y', { desc = "Copy to clipboard" })
