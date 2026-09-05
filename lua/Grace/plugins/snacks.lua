return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        -- Enable the high-performance picker module
        picker = {
            enabled = true,
            -- Replicates your Telescope 'smart' path display configuration
            formatters = {
                file = {
                    filename_first = true, -- Displays filename first, then directory path
                },
            },
            -- Keymaps inside the picker window
            win = {
                input = {
                    keys = {
                        -- Replicates your Telescope cursor movement and quickfix shortcuts
                        ["<C-k>"] = { "list_up", mode = { "i", "n" } },
                        ["<C-j>"] = { "list_down", mode = { "i", "n" } },
                        ["<C-q>"] = { "qflist", mode = { "i", "n" } },
                    },
                },
            },
        },
    },
    -- Replicates and maps your exact Telescope trigger keymaps to Snacks
    keys = {
        {
            "<leader>ff",
            function()
                Snacks.picker.files()
            end,
            desc = "Fuzzy find files in cwd",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Fuzzy find recent files",
        },
        {
            "<leader>fs",
            function()
                Snacks.picker.grep()
            end,
            desc = "Find string in cwd",
        },
        {
            "<leader>fc",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Find string under cursor in cwd",
        },
    },
}
