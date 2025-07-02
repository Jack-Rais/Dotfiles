
-- Impostare la variabile per settare dei bindings
local map = vim.keymap.set


-- Se eseguito, aspetta il carattere dopo e lo esegue senza aspettare l'invio 
map("n", "<leader>;", function()
    local char = vim.fn.getcharstr()
    return '<cmd>' .. char .. '<CR>'
end, { expr = true, desc = "1 char CMD" })

-- Inserisce la q come se fosse " quindi un comando come diq cancella tutto quello che c'è
-- dentro a delle "" o diQ per tutto quello che c'è dentro ''
map({ "o", "x" }, "iq", 'i"', { desc = 'inner ""' })
map({ "o", "x" }, "iQ", "i'", { desc = "inner ''" })

-- Quando si cancellano caratteri con x o X, quei caratteri non vengono copiati della clipboard
map({ "n", "v" }, "x", '"_x', { noremap = true, silent = true })
map({ "n", "v" }, "X", '"_X', { noremap = true, silent = true })

-- Incolla l'ultima cosa copiata nel registro, indipendentemente da cosa è stato cancellato
map({ "n", "v", "x" }, "<leader>p", '"0p', { desc = "Paste last yank" })

-- Impostare un marcatore seguito da una lettera, '(lettera) per tornare al Alternative_mapping_for_paste
map('n', '<leader>m', 'm', { desc = "Set mark" })

-- Passare da un errore all'altro
map("n", "<leader>k", "<cmd>cprev<CR><cmd>cclose<CR>", { desc = "Jump prev of quick fix list", silent = true })
map("n", "<leader>j", "<cmd>cnext<CR><cmd>cclose<CR>", { desc = "Jump next of quick fix list", silent = true })
map("n", "<leader>K", "<cmd>lprev<CR><cmd>lclose<CR>", { desc = "Jump prev of location list", silent = true })
map("n", "<leader>J", "<cmd>lnext<CR><cmd>lclose<CR>", { desc = "Jump next of location list", silent = true })


-- Chiude la penultima finestra aperta (utile per chiudere <leader>e (il file tree))
map("n", "<leader>q", function()
    vim.api.nvim_win_close(vim.fn.win_getid(vim.fn.winnr('#')), false)
end, { desc = "Close the previously focused window" })

-- Apre la ricerca dei simboli in telescope (variabili, funzioni ecc...)
map("n", "gs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search symbols in file", silent = true })

-- Apre le strutture del workspace in telescope (classi, struct, ecc) 
map('n', '<leader>fs', function()
    require('telescope.builtin').lsp_workspace_symbols()
end, { noremap = true, silent = true, desc = "Search symbols in workspace" }
)

-- Impostare l'estensione del file per attivare il server lsp corrispondente
map('n', "<leader>ct", ":set filetype=", { desc = "Set file type for lsp" })

-- Apre in telescope la storia degli yank di neovim, permettendo di scegliere quale incollare
map('n', "<leader>y", "<cmd>Telescope neoclip \" extra=star<CR>",
    { noremap = true, silent = true, desc = "Put yank nvim clipboard" })

-- Apre in telescope la storia degli yank di sistema, permettendo di scegliere quale Incolla
map('n', "<leader>Y", "<cmd>Telescope neoclip plus<CR>",
    { noremap = true, silent = true, desc = "Put yank to system clipboard" })



-- Crea scorciatoie per ogni buffer aperto (<leader>1 va al buffer 1 ecc...)
for i = 1, 9, 1 do
    map("n", string.format("<leader>%s", i), function()
        if i > #vim.t.bufs then
            i = #vim.t.bufs
        end
        require("nvchad.tabufline").goto_buf(vim.t.bufs[i])
    end, { desc = string.format("Open %sth Tab", i) })
end

-- Ritorna all'ultimo buffer attivo 
map('n', "<leader><leader>", "<C-^>"
, { silent = true, desc = "Open the previously focused buffer" })


-- Associa le scorciatoie nel file executors a tutti i linguaggi installati 
vim.api.nvim_create_augroup("executeFile", { clear = true })
for lang, keymap in pairs(require('executors')) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = lang,
        callback = keymap,
        group = "executeFile"
    })
end

-- Salva e formatta il file
map({ 'i', 'v', 'n' }, "<C-s>", "<Esc><cmd>lua vim.lsp.buf.format()<CR><cmd>w<CR>",
    { noremap = true, silent = true, desc = "Format then save the file then <Esc>" })



-- Debugger mappings
-- -- Moved to plugins/init for lazy loading


-- Reply to Shreyas
local function buf_index(bufnr)
    for i, value in ipairs(vim.t.bufs) do
        if value == bufnr then
            return i
        end
    end
end

-- Muovi la finestra nelle tab per un tot di posizioni (con numeri negativi supportati)
map('n', "<leader>tm", function()
    local n = tonumber(vim.fn.input("Move tab by (negetive number to move left): "))
    local current_idx = buf_index(vim.api.nvim_get_current_buf())
    if current_idx + n > #vim.t.bufs then
        n = #vim.t.bufs - current_idx
    end
    if current_idx + n < 1 then
        n = -current_idx + 1
    end
    require('nvchad.tabufline').move_buf(n)
end, { desc = "Move the tab position" })

-- Muovi la finestra a destra e a sinistra nelle tab
map('n', "<M-Left>", function()
    if buf_index(vim.api.nvim_get_current_buf()) > 1 then
        require('nvchad.tabufline').move_buf(-1)
    end
end, { desc = "Move the tab left" })

map('n', "<M-Right>", function()
    if buf_index(vim.api.nvim_get_current_buf()) < #vim.t.bufs then
        require('nvchad.tabufline').move_buf(1)
    end
end, { desc = "Move the tab right" })


-- Usa relative numbers
map('n', "<leader>n", function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
end, { desc = "Use relative number" })


-- Vai all'inizio o alla fine di una riga in insert mode
map('i', "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map('i', "<C-e>", "<End>", { desc = "End of line" })

-- Muoversi con hjkl in insert mode 
map('i', "<C-h>", "<Left>", { desc = "Move left" })
map('i', "<C-l>", "<Right>", { desc = "Move right" })
map('i', "<C-j>", "<Down>", { desc = "Move down" })
map('i', "<C-k>", "<Up>", { desc = "Move up" })

-- Pulisci tutte le evidenziazioni
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })


-- switch between windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })


-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })
map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })


-- Crea nuovo file
map("n", "<leader>b", function()
    vim.cmd [[enew]]
end, { desc = "New buffer" })

-- Apri la documentazione per tutte le scorciatoie
map("n", "<leader>ch", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

-- Formatta il file
map("n", "<leader>fm",
    function()
        vim.lsp.buf.format { async = true }
    end,
    { desc = "LSP formatting" }
)

-- Indenta la riga (funziona solo in visual mode con la riga selezionata)
map("n", "<", "<gv", { desc = "Indent line" })
map("n", ">", ">gv", { desc = "Indent line" })

-- Non copiare il testo rimpiazzato dopo un paste
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })


-- Ruotare tra i buffer aperti
map("n", "<tab>",
    function()
        require("nvchad.tabufline").next()
    end,
    { desc = "Goto next buffer" })

-- Ruotare tra i buffer aperti in senso opposto
map("n", "<S-tab>",
    function()
        require("nvchad.tabufline").prev()
    end,
    { desc = "Goto prev buffer" })

-- Chiude buffer o il terminale
map("n", "<M-x>",
    function()
        require("nvchad.tabufline").close_buffer()
    end,
    { desc = "Close buffer" })

-- In tutte e due le modalità (n, v) imposta il commento
map("n", "<leader>/",
    function()
        require("Comment.api").toggle.linewise.current()
    end,
    { desc = "Toggle comment" })

map("v", "<leader>/",
    "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Toggle comment" }
)


map('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded' })
end, { desc = 'LSP documentation' })

map("n", "<leader>lf",
    function()
        vim.diagnostic.open_float { border = "rounded" }
    end,
    { desc = "Floating diagnostic" })

map("n", "<leader>sh", function()
    vim.lsp.buf.signature_help({ border = "rounded" })
end, { desc = "Signature help" })

map("n", "[d",
    function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
    end,
    { desc = "Goto prev" })


map("n", "]d",
    function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
    end,
    { desc = "Goto next" }
)

map("n", "<leader>lq",
    function()
        vim.diagnostic.setloclist()
    end,
    { desc = "Diagnostic setloclist" })

map("n", "<leader>wa",
    function()
        vim.lsp.buf.add_workspace_folder()
    end,
    { desc = "Add workspace folder" })

map("n", "<leader>wr",
    function()
        vim.lsp.buf.remove_workspace_folder()
    end,
    { desc = "Remove workspace folder" })

map("n", "<leader>wl",
    function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end,
    { desc = "List workspace folders" })

-- toggle
map("n", "<A-f>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
-- focus
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

map("n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<leader>fw", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", { desc = "Find in current buffer" })

-- git
map("n", "<leader>gc", "<cmd> Telescope git_commits <CR>", { desc = "Git commits" })
map("n", "<leader>gt", "<cmd> Telescope git_status <CR>", { desc = "Git status" })

-- pick a hidden term
map("n", "<leader>ft", "<cmd> Telescope terms <CR>", { desc = "Pick hidden term" })

-- theme switcher
map("n", "<leader>th", "<cmd> Telescope themes <CR>", { desc = "Nvchad themes" })

map("n", "<leader>fb", "<cmd> Telescope marks <CR>", { desc = "telescope bookmarks" })
-- toggle in terminal mode
map({ "n", "t" }, "<A-v>", function()
    require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
    require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "terminal toggle floating term" })


-- Apre il terminale in basso 
map("n", "<leader>h", function()
    require("nvchad.term").new { pos = "sp" }
end, { desc = "terminal new horizontal term" })

-- Chiude il teminale
vim.keymap.set("t", "<C-ò>", "<C-\\><C-n>:bd!<CR>", { desc = "close terminal" })

-- Apre il terminale a destra 
map("n", "<leader>v", function()
    require("nvchad.term").new { pos = "vsp" }
end, { desc = "terminal new vertical term" })


-- Mostra tutte le scorciatoie
map("n", "<leader>wK",
    function()
        vim.cmd "WhichKey"
    end,
    { desc = "Which-key all keymaps" })

-- Lascia cercare tra le scorciatoie
map("n", "<leader>wk",
    function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
    end,
    { desc = "Which-key query lookup" })


-- Salta sul blocco di codice padre (se in un blocco if, salta sul nome della funzione in cui si è)
map("n", "<leader>cc",
    function()
        require("treesitter-context").go_to_context(vim.v.count1)
    end,
    { desc = "Jump to sticky context", silent = true }
)


-- Spostati in basso per un pezzo di codice
map("n", "]h",
    function()
        vim.schedule(function()
            require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
    end,
    { desc = "Jump to next hunk", expr = true }
)

-- Spostati in alto per un pezzo di codice
map("n", "[h",
    function()
        vim.schedule(function()
            require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
    end,
    { desc = "Jump to prev hunk", expr = true }
)

-- Ripristina il blocco di codice eliminato 
map("n", "<leader>rh",
    function()
        require("gitsigns").reset_hunk()
    end,
    { desc = "Reset hunk" })

-- Mostra un popup con le modifiche del blocco di codice
map("n", "<leader>gh",
    function()
        require("gitsigns").preview_hunk()
    end,
    { desc = "Preview hunk" })

-- Eseguire git add, sul blocco di codice
map("n", "<leader>gs",
    function()
        require("gitsigns").stage_hunk()
    end,
    { desc = "Stage hunk" })

-- Mostra chi ha modificato la riga e quando in git
map("n", "<leader>gb",
    function()
        package.loaded.gitsigns.blame_line()
    end,
    { desc = "Blame line" })

-- Mostra o nasconde le righe eliminate
map("n", "<leader>td",
    function()
        require("gitsigns").toggle_deleted()
    end,
    { desc = "Toggle deleted" })
