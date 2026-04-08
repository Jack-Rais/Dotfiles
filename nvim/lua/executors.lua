-- executors.lua
local Terminal = require("toggleterm.terminal").Terminal

local M = {}

local function make_term(direction, cmd)
    return Terminal:new({ direction = direction, cmd = cmd, close_on_exit = false })
end

local function setup_keymaps(cmd, test_cmd)
    local opts = { buffer = true, noremap = true, silent = true }

    vim.keymap.set("n", "<leader>xv", function()
        vim.cmd("w")
        make_term("vertical", cmd):toggle()
    end, opts)

    vim.keymap.set("n", "<leader>xh", function()
        vim.cmd("w")
        make_term("horizontal", cmd):toggle()
    end, opts)

    vim.keymap.set("n", "<leader>xf", function()
        vim.cmd("w")
        make_term("float", cmd):toggle()
    end, opts)

    if test_cmd then
        vim.keymap.set("n", "<leader>Xv", function()
            vim.cmd("w")
            make_term("vertical", test_cmd):toggle()
        end, opts)

        vim.keymap.set("n", "<leader>Xh", function()
            vim.cmd("w")
            make_term("horizontal", test_cmd):toggle()
        end, opts)
    end
end

local executors = {
    ["javascript,typescript"] = function()
        setup_keymaps("node " .. vim.fn.expand("%"))
    end,
    ["python"] = function()
        setup_keymaps("python " .. vim.fn.expand("%"))
    end,
    ["cpp"] = function()
        local bin = vim.fn.expand("%:t:r")
        local file = vim.fn.expand("%")
        setup_keymaps(
            string.format("g++ %s -o %s && ./%s", file, bin, bin),
            string.format("g++ %s -o %s && ./%s<test.txt", file, bin, bin)
        )
    end,
    ["c"] = function()
        local bin = vim.fn.expand("%:t:r")
        local file = vim.fn.expand("%")
        setup_keymaps(string.format("gcc %s -o %s && ./%s", file, bin, bin))
    end,
    ["zig"] = function()
        local dir = vim.fn.expand("%:p:h")
        setup_keymaps(
            "cd " .. dir .. "; zig build run",
            "cd " .. dir .. "; zig test"
        )
    end,
    ["rust"] = function()
        local dir = vim.fn.expand("%:p:h")
        setup_keymaps(
            "cd " .. dir .. "; cargo run",
            "cd " .. dir .. "; cargo test"
        )
    end,
}

function M.setup()
    for filetypes, executor_fn in pairs(executors) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = executor_fn,
        })
    end
end

return M
