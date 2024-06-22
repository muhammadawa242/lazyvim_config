-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<A-j>", ":m .+1<CR>") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>") -- move line down(n)
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>") -- f8 to open TagbarToggle
vim.keymap.set("n", "zz", "<cmd>GlobalNote<cr>") -- for global note
vim.keymap.set("n", "<A-t>", "<cmd>TransparentToggle<cr>") -- for global note
vim.keymap.set("n", "<C-A-c>", "<cmd>CellularAutomaton make_it_rain<cr>")
vim.keymap.set("n", "<C-A-x>", "<cmd>CellularAutomaton game_of_life<cr>")
