local Terminal = require("toggleterm.terminal").Terminal

-- ============================================================
-- HELPERS
-- ============================================================

local function make_term(direction, cmd)
    return Terminal:new({ direction = direction, cmd = cmd, close_on_exit = false })
end

local function execute(cmd)
    local map = vim.keymap.set
    local opts = { buffer = true }

    map("n", "<leader>xv", function()
        vim.cmd("w")
        make_term("vertical", cmd):toggle()
    end, opts)

    map("n", "<leader>xh", function()
        vim.cmd("w")
        make_term("horizontal", cmd):toggle()
    end, opts)

    map("n", "<leader>xf", function()
        vim.cmd("w")
        make_term("float", cmd):toggle()
    end, opts)
end

local function execute_test(cmd)
    local map = vim.keymap.set
    local opts = { buffer = true }

    map("n", "<leader>Xv", function()
        vim.cmd("w")
        make_term("vertical", cmd):toggle()
    end, opts)

    map("n", "<leader>Xh", function()
        vim.cmd("w")
        make_term("horizontal", cmd):toggle()
    end, opts)
end

-- ============================================================
-- LANGUAGE RUNNERS
-- ============================================================

local expand = vim.fn.expand

return {
    ["javascript,typescript"] = function()
        execute("node " .. expand("%"))
    end,

    ["python"] = function()
        execute("python " .. expand("%"))
    end,

    ["cpp"] = function()
        local bin = expand("%:t:r")
        execute(      string.format("g++ %s -o %s && ./%s",           expand("%"), bin, bin))
        execute_test( string.format("g++ %s -o %s && ./%s<test.txt",  expand("%"), bin, bin))
    end,

    ["c"] = function()
        local bin = expand("%:t:r")
        execute(string.format("gcc %s -o %s && ./%s", expand("%"), bin, bin))
    end,

    ["zig"] = function()
        local dir = expand("%:p:h")
        execute(      "cd " .. dir .. "; zig build run")
        execute_test( "cd " .. dir .. "; zig test")
    end,

    ["rust"] = function()
        local dir = expand("%:p:h")
        execute(      "cd " .. dir .. "; cargo run")
        execute_test( "cd " .. dir .. "; cargo test")
    end,
}
