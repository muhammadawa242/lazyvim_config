-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<A-j>", ":m .+1<CR>") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>") -- move line down(n)
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>") -- f8 to open TagbarToggle
vim.keymap.set("n", "zz", "<cmd>GlobalNote<cr>") -- for global note
vim.keymap.set("n", "<A-t>", "<cmd>TransparentToggle<cr>") -- for global note
-- vim.keymap.set("n", "<C-c>", "<cmd>CellularAutomaton make_it_rain<cr>")
-- vim.keymap.set("n", "<C-x>", "<cmd>CellularAutomaton game_of_life<cr>")
vim.keymap.set("i", "<A-x>", "<Esc>dbxi")
vim.keymap.set("i", "<A-u>", "<Esc>uwi")
vim.keymap.set("n", "<A-l>", "<cmd>Gitsigns next_hunk<cr>")
vim.keymap.set("n", "<A-h>", "<cmd>Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "<F5>", "<cmd>UndotreeToggle<cr>")
-- vim.keymap.set("n", "<C-b>", "<cmd>Gitsigns blame_line<cr>")
-- vim.keymap.set("n", "<C-k>", "<cmd>Gitsigns preview_hunk<cr>")
