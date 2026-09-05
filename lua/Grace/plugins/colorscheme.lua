return {
    {
        "yazeed1s/oh-lucy.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- Enable optional italic styles supported natively by the theme
            vim.g.oh_lucy_italic_comments = true
            vim.g.oh_lucy_italic_functions = true

            -- Select your preferred stock variant here:
            -- Use "oh-lucy" for the standard dark background
            -- Use "oh-lucy-evening" for the deeper midnight background
            vim.cmd([[colorscheme oh-lucy]])
        end,
    },
}
--
-- -- return {
-- --     "sainnhe/everforest",
-- --     lazy = false,
-- --     priority = 1000,
-- --     config = function()
-- --         -- Set background to dark
-- --         vim.o.background = "dark"
-- --
-- --         -- Choose the contrast variant: 'hard', 'medium', or 'soft'
-- --         vim.g.everforest_background = "hard"
-- --
-- --         -- Optimize loading performance
-- --         vim.g.everforest_better_performance = 1
-- --
-- --         -- Load the colorscheme
-- --         vim.cmd([[colorscheme everforest]])
-- --     end,
-- -- }
