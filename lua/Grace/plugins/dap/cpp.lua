local dap = require("dap")

---------------------------------------------------
-- CodeLLDB Adapter
---------------------------------------------------

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
        args = { "--port", "${port}" },
    },
}

---------------------------------------------------
-- C / C++ Configuration
---------------------------------------------------

dap.configurations.cpp = {
    {
        name = "Compile & Debug Current File",
        type = "codelldb",
        request = "launch",

        program = function()
            vim.cmd("write")

            local current_file = vim.fn.expand("%")
            local executable = vim.fn.expand("%:r")

            local compile_cmd = string.format('g++ -std=c++20 -g "%s" -o "%s"', current_file, executable)

            print("Compiling with debug symbols...")

            local result = vim.fn.system(compile_cmd)

            if vim.v.shell_error ~= 0 then
                vim.notify("Compilation failed:\n" .. result, vim.log.levels.ERROR)
                return nil
            end

            return vim.fn.getcwd() .. "/" .. executable
        end,

        cwd = "${workspaceFolder}",

        stopOnEntry = false,

        stdio = {
            "input.txt",
            nil,
        },

        runInTerminal = false,
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
