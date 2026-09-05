--[[return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "curved",
            },
        })

        local Terminal = require("toggleterm.terminal").Terminal
        local active_input_runner = nil

        vim.keymap.set("n", "<F5>", function()
            -- 1. Save file changes
            vim.cmd("w")

            local file = vim.fn.expand("%")
            local exe = vim.fn.expand("%:r")

            -- 2. Build task execution string with redirected input file
            local cmd = string.format(
                'g++ -std=c++20 -O2 "%s" -o "%s" && ./"%s" < input.txt; echo ""; echo "-----------------------------"; echo "Process finished. Press Enter to exit..."; read',
                file,
                exe,
                exe
            )

            -- 3. If the float layout is currently open, kill its active thread safely
            if active_input_runner then
                active_input_runner:shutdown()
            end

            -- 4. Initialize clean isolated floating layout process window
            local Terminal = require("toggleterm.terminal").Terminal
            active_input_runner = Terminal:new({
                cmd = cmd,
                direction = "float",
                close_on_exit = true, -- Closes the panel automatically when you hit Enter on the read prompt
                hidden = true,
            })

            -- 5. Open layout panel
            active_input_runner:toggle()
        end, { desc = "Run C++ with isolated pure input.txt environment" })
    end,
}
--Static HORIZONTAL TERMINAL IF YOU LIKE---]]

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "float",
            float_opts = {
                border = "curved",
            },
        })

        local Terminal = require("toggleterm.terminal").Terminal

        -- Tracks the active bottom terminal object to prevent duplicates
        local active_input_runner = nil

        vim.keymap.set("n", "<F5>", function()
            -- 1. Auto-save your current code
            vim.cmd("w")

            local file = vim.fn.expand("%")
            local exe = vim.fn.expand("%:r")

            -- 2. Build task execution string with redirected input file
            local cmd = string.format(
                'g++ -std=c++20 -O2 "%s" -o "%s" && ./"%s" < input.txt; echo ""; echo "Press Enter to close..."; read',
                file,
                exe,
                exe
            )

            -- 3. If a previous layout is open, kill its active thread safely
            if active_input_runner then
                active_input_runner:shutdown()
            end

            -- 4. CHANGED: Initialized as a flat horizontal split at the bottom instead of a float
            active_input_runner = Terminal:new({
                cmd = cmd,
                direction = "horizontal", -- Opens at the bottom
                size = 15, -- Restricts height exactly like F6
                close_on_exit = true, -- Auto-closes the panel when you hit Enter on the read prompt
                hidden = true,
            })

            -- 5. Open layout panel
            active_input_runner:toggle()
        end, { desc = "Run C++ with input.txt in bottom split" })
    end,
}
