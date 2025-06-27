
-- lua/user/lsp/servers.lua
local M = {}
local util = vim.lsp.util
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function make_root_dir(markers)
  return function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.dirname(vim.fs.find(markers, { upward = true, path = fname })[1])
    if root then
      on_dir(root)
    else
      on_dir(vim.fs.dirname(fname))
    end
  end
end

function M.setup()
  -- Python LSP
  vim.lsp.config['pylsp'] = {
    cmd = { 'pylsp' },
    capabilities = capabilities,
    filetypes = { 'python' },
    root_dir = make_root_dir({ 'setup.py', 'pyproject.toml', '.git' }),
    settings = {
      pylsp = { plugins = { jedi_completion = { include_params = true } } },
    },
  }
  vim.lsp.enable('pylsp')

  -- Rust LSP
  vim.lsp.config['rust_analyzer'] = {
    cmd = { 'rust-analyzer' },
    capabilities = capabilities,
    filetypes = { 'rust' },
    root_dir = make_root_dir({ 'Cargo.toml', '.git' }),
  }
  vim.lsp.enable('rust_analyzer')
end

return M
