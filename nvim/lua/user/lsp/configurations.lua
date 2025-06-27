
-- lua/user/lsp/configurations.lua
local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local buf = ev.buf

      vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      if client.supports_method('textDocument/completion') then
        vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, {
          buffer = buf,
          desc = "Trigger LSP completion",
        })
      end

      -- Signature help: mostra la firma della funzione (es. dentro le parentesi)
      if client.supports_method('textDocument/signatureHelp') then
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, {
          buffer = buf,
          desc = "Show signature help",
        })
      end

    end,
  })

  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
end


return M
