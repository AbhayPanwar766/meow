vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost", "BufEnter" }, {
    pattern = "*.cpp",
    callback = function()
        -- Confirm the active file buffer is entirely empty
        if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
            -- Dynamically fetch your active Neovim path (~/.config/nvim/)
            local config_path = vim.fn.stdpath("config")
            local template_path = config_path .. "/lua/Grace/templates/cpp.template"

            if vim.fn.filereadable(template_path) == 1 then
                -- Load template contents cleanly
                vim.cmd("silent 0r " .. template_path)
                -- Clear out any trailing artifacts and place cursor at bottom
                vim.cmd("normal! G")
                -- Clear modified state so empty buffers close gracefully if untouched
                vim.bo.modified = false
            else
                -- Help debug if the file is still misplaced or unreadable
                vim.notify("CP Template file missing at: " .. template_path, vim.log.levels.WARN)
            end
        end
    end,
})
