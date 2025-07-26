
local function execute_terminal(cmd)
    
    local Terminal = require("toggleterm.terminal").Terminal
    vim.keymap.set('n', '<leader>xv', function()
        vim.cmd('w')
        
        local vertical_term = Terminal:new {
            direction = "vertical",
            cmd = cmd,
            close_on_exit = false
        }
        vertical_term:toggle()

    end, { buffer = true, desc = "Execute current file in vertical terminal" })


    vim.keymap.set('n', '<leader>xh', function()
        vim.cmd('w')
        
        local horizontal_term = Terminal:new {
            direction = "horizontal",
            cmd = cmd,
            close_on_exit = false
        }
        horizontal_term:toggle()

    end, { buffer = true, desc = "Execute current file in horizontal terminal" })

end

local function execute_terminal_test(cmd)
    
    local Terminal = require("toggleterm.terminal").Terminal
    vim.keymap.set('n', '<leader>Xv', function()
        vim.cmd('w')
        
        local vertical_term = Terminal:new {
            direction = "vertical",
            cmd = cmd,
            close_on_exit = false
        }
        vertical_term():toggle()

    end, { buffer = true, desc = "Execute tests in vertical terminal" })
    vim.keymap.set('n', '<leader>Xh', function()
        vim.cmd('w')
        
        local horizontal_term = Terminal:new {
            direction = "horizontal",
            cmd = cmd,
            close_on_exit = false
        }
        horizontal_term:toggle()

    end, { buffer = true, desc = "Execute tests in horizontal terminal" })
end

return {
    ["javascript,typescript"] = function()
        local cmd = "node " .. vim.fn.expand("%")
        execute_terminal(cmd)
    end,

    ["python"] = function()
        local cmd = "python " .. vim.fn.expand("%")
        execute_terminal(cmd)
    end,

    ["cpp"] = function()
        local cmd = string.format("g++ %s -o %s && ./%s", vim.fn.expand("%"), vim.fn.expand("%:t:r"),
            vim.fn.expand("%:t:r"))
        execute_terminal(cmd)
        local test_cmd = string.format("g++ %s -o %s && ./%s<test.txt", vim.fn.expand("%"), vim.fn.expand("%:t:r"),
            vim.fn.expand("%:t:r"))
        execute_terminal_test(test_cmd)
    end,

    ["c"] = function()
        local cmd = string.format("gcc %s -o %s && ./%s", vim.fn.expand("%"), vim.fn.expand("%:t:r"),
            vim.fn.expand("%:t:r"))
        execute_terminal(cmd)
    end,

    ["rust"] = function()
        local cmd = "cd " .. vim.fn.expand("%:p:h") .. "; cargo run"
        execute_terminal(cmd)

        local test_cmd = "cd " .. vim.fn.expand("%:p:h") .. "; cargo test"
        execute_terminal_test(test_cmd)
    end,
    ["html"] = function()
        local cmd = "cd " .. vim.fn.expand("%:p:h") .. "&&live-server"
        execute_terminal(cmd)
    end
}
