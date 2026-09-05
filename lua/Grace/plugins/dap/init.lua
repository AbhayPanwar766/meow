return {
    "mfussenegger/nvim-dap",

    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio",

        "jay-babu/mason-nvim-dap.nvim",

        "mxsdev/nvim-dap-vscode-js",
    },

    config = function()
        require("Grace.plugins.dap.signs")
        require("Grace.plugins.dap.ui")
        require("Grace.plugins.dap.cpp")
        require("Grace.plugins.dap.javascript")

        local dap = require("dap")
        local dapui = require("dapui")

        -------------------------
        -- Keymaps
        -------------------------

        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
        vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Breakpoint" })

        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end)

        vim.keymap.set("n", "<leader>dl", function()
            dap.set_breakpoint(nil, nil, vim.fn.input("Log point: "))
        end)

        vim.keymap.set("n", "<leader>dr", dap.repl.open)

        vim.keymap.set("n", "<leader>du", dapui.toggle)

        vim.keymap.set("n", "<leader>dx", function()
            dap.terminate()
            dapui.close()
        end)
        vim.keymap.set("n", "<leader>dR", function()
            require("dap").restart()
        end, { desc = "Debug: Restart" })
        vim.keymap.set("n", "<leader>dg", function()
            require("dap").run_to_cursor()
        end, { desc = "Debug: Run to Cursor" })
        vim.keymap.set("n", "<leader>dC", function()
            require("dap").clear_breakpoints()
        end, { desc = "Debug: Clear Breakpoints" })
        vim.keymap.set({ "n", "v" }, "<leader>dh", function()
            require("dap.ui.widgets").hover()
        end, { desc = "Debug: Hover" })
        vim.keymap.set("n", "<leader>ds", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.scopes)
        end, { desc = "Debug: Scopes" })
        vim.keymap.set("n", "<leader>df", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.frames)
        end, { desc = "Debug: Frames" })
        vim.keymap.set("n", "<leader>dt", function()
            local widgets = require("dap.ui.widgets")
            widgets.centered_float(widgets.threads)
        end, { desc = "Debug: Threads" })
        vim.keymap.set("n", "<leader>dq", function()
            require("dap").repl.toggle()
        end, { desc = "Debug: Toggle REPL" })
        vim.keymap.set("n", "<leader>dd", function()
            require("dap").repl.open()
        end)
    end,
}
