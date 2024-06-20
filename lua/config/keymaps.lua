-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<A-j>", ":m .+1<CR>") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>") -- move line down(n)
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>") -- f8 to open TagbarToggle
