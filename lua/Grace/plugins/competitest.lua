return {
    "xeluxee/competitest.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    lazy = false,

    config = function()
        require("competitest").setup({

            runner_ui = {
                interface = "split",
                selector_show_nu = true,
                selector_show_rnu = false,
                position = "right",
                relative_width = 0.45,
                border = "rounded",
            },
            compile_directory = ".",

            compile_command = {
                cpp = {
                    exec = "g++",
                    args = {
                        "-std=c++20",
                        "-O2",
                        "$(FNAME)",
                        "-o",
                        "$(FNOEXT)",
                    },
                },
            },

            run_command = {
                cpp = {
                    exec = "./$(FNOEXT)",
                },
            },

            evaluate_time_limit = 5000,
            received_problems_path = "$(CWD)/$(PROBLEM).$(FEXT)",
            received_problems_prompt_path = false,

            template_file = {
                cpp = "~/.config/nvim/lua/Grace/templates/cpp.template",
            },
        })

        local keymap = vim.keymap.set

        keymap("n", "<leader>cr", "<cmd>CompetiTest run<CR>", { desc = "Run tests" })
        keymap("n", "<leader>cf", "<cmd>CompetiTest add_testcase<CR>", { desc = "Add testcase" })
        keymap("n", "<leader>ce", "<cmd>CompetiTest edit_testcase<CR>", { desc = "Edit testcase" })
        keymap("n", "<leader>cd", "<cmd>CompetiTest delete_testcase<CR>", { desc = "Delete testcase" })
        keymap("n", "<leader>cp", "<cmd>CompetiTest receive problem<CR>", { desc = "Receive problem" })
        keymap("n", "<leader>cc", "<cmd>CompetiTest receive contest<CR>", { desc = "Receive contest" })
    end,
}
