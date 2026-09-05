return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- Enable mason and configure standard interface icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- FIXED: Cleaned duplication and aligned with your native LSP setup definitions
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "lua_ls",
                "graphql",
                "emmet_language_server", -- Keeping the official modern server (removed emmet_ls)
                "prismals",
                "pyright",

                -- Note: If you want to use "vtsls", "eslint", or "jdtls",
                -- remember to declare them in your lsp config file too!
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- Prettier formatter
                "stylua", -- Lua formatter
                "isort", -- Python import sorter
                "black", -- Python formatter
                "pylint", -- Python linter
                "eslint_d", -- Fast JavaScript linter daemon
            },
        })
    end,
}
