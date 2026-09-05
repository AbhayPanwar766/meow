local dap = require("dap")
local dapui = require("dapui")

---------------------------------------------------
-- mason-nvim-dap
---------------------------------------------------

require("mason-nvim-dap").setup({
    ensure_installed = {
        "codelldb",
        "js",
    },

    automatic_installation = true,
})

---------------------------------------------------
-- DAP UI
---------------------------------------------------

dapui.setup()

---------------------------------------------------
-- Virtual Text
---------------------------------------------------

require("nvim-dap-virtual-text").setup({
    enabled = true,
    enabled_commands = true,

    highlight_changed_variables = true,
    highlight_new_as_changed = true,

    show_stop_reason = true,

    commented = false,
})

---------------------------------------------------
-- Terminal
---------------------------------------------------

dap.defaults.fallback.terminal_win_cmd = "belowright 12split new"

---------------------------------------------------
-- Auto Open UI
---------------------------------------------------

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

---------------------------------------------------
-- NOTE:
-- We intentionally keep the UI open after the
-- program exits so variables remain visible.
---------------------------------------------------
