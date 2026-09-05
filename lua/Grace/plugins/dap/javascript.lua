local dap = require("dap")

---------------------------------------------------
-- VS Code JS Debug
---------------------------------------------------

require("dap-vscode-js").setup({
    debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
    adapters = {
        "pwa-node",
        "node-terminal",
        "pwa-chrome",
        "pwa-msedge",
    },
})

---------------------------------------------------
-- Node.js
---------------------------------------------------

dap.configurations.javascript = {
    {
        type = "pwa-node",
        request = "launch",
        name = "Launch Current File",

        program = "${file}",
        cwd = "${workspaceFolder}",

        sourceMaps = true,
        console = "integratedTerminal",

        skipFiles = {
            "<node_internals>/**",
        },
    },
}

---------------------------------------------------
-- Reuse for TS / React
---------------------------------------------------

dap.configurations.typescript = dap.configurations.javascript
dap.configurations.javascriptreact = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
