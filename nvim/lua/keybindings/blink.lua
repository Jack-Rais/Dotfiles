
local M = {}


function M.get_mappings()
    
    return {
        preset = "none",

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

        ['<Tab>'] = { 'select_next', 'fallback'},
        ['<S-Tab>'] = { 'select_prev', 'fallback'},
        
        ['<C-CR>'] = { 'select_and_accept' }
    }

end

return M
