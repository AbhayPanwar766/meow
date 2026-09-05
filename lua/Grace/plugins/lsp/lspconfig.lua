return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        -- Import plugins
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

        -- Keymaps attached natively on LSP initialization
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                opts.desc = "Show LSP references"
                keymap.set("n", "gR", function()
                    Snacks.picker.lsp_references()
                end, opts)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", function()
                    Snacks.picker.lsp_definitions()
                end, opts)

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", function()
                    Snacks.picker.lsp_implementations()
                end, opts)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", function()
                    Snacks.picker.lsp_type_definitions()
                end, opts)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", function()
                    Snacks.picker.diagnostics({ filter = { bufnr = 0 } })
                end, opts)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", function()
                    vim.diagnostic.jump({ cont = -1 })
                end, opts)

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", function()
                    vim.diagnostic.jump({ count = 1 })
                end, opts)

                opts.desc = "Show documentation"
                keymap.set("n", "K", vim.lsp.buf.hover, opts)

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
            end,
        })

        -- Native base configuration capabilities configuration
        local capabilities = cmp_nvim_lsp.default_capabilities()
        local default_config = {
            capabilities = capabilities,
        }

        -- Modern diagnostic styling structure
        local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = signs.Error,
                    [vim.diagnostic.severity.WARN] = signs.Warn,
                    [vim.diagnostic.severity.HINT] = signs.Hint,
                    [vim.diagnostic.severity.INFO] = signs.Info,
                },
            },
        })

        -- -------------------------------------------------------------
        -- NEW NATIVE LSP MANAGEMENT BLOCK (vim.lsp.config & vim.lsp.enable)
        -- -------------------------------------------------------------

        -- 1. Base Setup for Standard Servers
        local servers = { "html", "cssls", "ts_ls", "tailwindcss", "prismals", "pyright" }
        for _, server in ipairs(servers) do
            vim.lsp.config(server, default_config)
            vim.lsp.enable(server)
        end

        -- 2. Svelte
        vim.lsp.config("svelte", default_config)
        vim.lsp.enable("svelte")
        -- Custom Svelte logic migrated to native LspAttach autocmd
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.name == "svelte" then
                    vim.api.nvim_create_autocmd("BufWritePost", {
                        pattern = { "*.js", "*.ts" },
                        callback = function(ctx)
                            client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                        end,
                    })
                end
            end,
        })

        -- 3. GraphQL
        vim.lsp.config("graphql", {
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
        vim.lsp.enable("graphql")

        -- 4. Emmet
        vim.lsp.config("emmet_language_server", {
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
        vim.lsp.enable("emmet_language_server")

        -- 5. Lua
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    telemetry = { enable = false },
                },
            },
        })
        vim.lsp.enable("lua_ls")
    end,
}
