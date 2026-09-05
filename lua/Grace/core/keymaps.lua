-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- C++ compile and run with input.txt
-- C++ compile and run interactively
-- Helper variable stored outside the function to track the execution layout structure
local active_clean_runner = nil

keymap.set("n", "<F6>", function()
    -- 1. Auto-save the current working buffer file
    vim.cmd("w")

    -- 2. Fetch path and name information dynamically
    local current_file = vim.fn.expand("%")
    local executable = vim.fn.expand("%:r")

    -- 3. Construct clean compilation and execute command strings
    -- 'clear' is omitted from the executable task string because it runs raw, without shell history artifacts
    local run_cmd = string.format("g++ -std=c++20 -O2 %s -o %s && ./%s", current_file, executable, executable)

    -- 4. If a previous run window layout is already open, cleanly shut down its buffer thread
    if active_clean_runner then
        active_clean_runner:shutdown()
    end

    -- 5. Build a fresh isolated runner that executes your program directly as a pure process
    local Terminal = require("toggleterm.terminal").Terminal
    active_clean_runner = Terminal:new({
        cmd = run_cmd, -- Executes the raw string layout directly as the task shell process itself
        hidden = true, -- Prevents flashing artifacts during creation
        direction = "vertical",
        size = 15,
        close_on_exit = false, -- Freezes the screen so you can comfortably inspect your outputs
    })

    -- 6. Slide open the clean window layout
    active_clean_runner:toggle()
end, { desc = "Run C++ with absolute isolated pure output" })
