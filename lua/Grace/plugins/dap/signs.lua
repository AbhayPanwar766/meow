vim.fn.sign_define("DapBreakpoint", {
    text = "●",
    texthl = "DiagnosticError",
})

vim.fn.sign_define("DapBreakpointCondition", {
    text = "◆",
    texthl = "DiagnosticWarn",
})

vim.fn.sign_define("DapStopped", {
    text = "▶",
    texthl = "DiagnosticWarn",
})

vim.fn.sign_define("DapBreakpointRejected", {
    text = "",
    texthl = "DiagnosticError",
})
