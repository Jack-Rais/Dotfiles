
-- lua/user/lsp/configurations.lua
local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      local buf = ev.buf

      -- Abilita omnifunc nativa LSP
      vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      if client.supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, {
          buffer = buf,
          desc = "Trigger LSP completion",
        })
      end

      -- Premi Invio per accettare il suggerimento
      vim.keymap.set('i', '<CR>', function()
        if vim.fn.pumvisible() == 1 then
          return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
        else
          return '\r'
        end
      end, { expr = true, buffer = buf })
    end,
  })

  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
end

return M

