-- [[ Basic Keymaps ]]
--   See ':help vim.keymap.set()'

local keymap = vim.keymap

-- Clear highlights on search when pressing <Esc> in normal mode
--   See ':help hlsearch'
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

--[[ Windows, Tabs, and Buffers ]]
-- See ':help wincmd' for a list of all window commands

-- Window Splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit window [V]ertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit window [H]orizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make [S]plit windows [=]equal width" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Window Focus: make split navigation easier
--   Use CTRL+<hjkl>to switch between windows
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab [O]pen" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab [X]close" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab [P]revious" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open new [T]ab for current bu[F]fer" })

-- Buffers
keymap.set("n", "<leader>bn", ":bn<CR>", { desc = "[B]uffer [N]ext" })
keymap.set("n", "<leader>bp", ":bp<CR>", { desc = "[B]uffer [P]revious" })
keymap.set("n", "<leader>bx", ":bd<CR>", { desc = "[B]uffer [X]close" })
keymap.set("n", "<leader>br", ":b#<CR>", { desc = "[B]uffer [R]ecent" })

-- vim: ts=2 sts=2 sw=2 et
