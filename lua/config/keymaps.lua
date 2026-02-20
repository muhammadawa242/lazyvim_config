-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local marks = require("utils.marks")

vim.keymap.set("n", "<A-j>", ":m .+1<CR>") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>") -- move line down(n)
vim.keymap.set("n", "<F8>", ":TagbarToggle<CR>") -- f8 to open TagbarToggle
vim.keymap.set("n", "zz", "<cmd>GlobalNote<cr>") -- for global note
vim.keymap.set("n", "<leader>ww", "<cmd>TodoNote<cr>") -- for todo note
vim.keymap.set("n", "<leader>hh", "<cmd>HowNote<cr>") -- for how note
vim.keymap.set("n", "<leader>tt", "<cmd>DevNote<cr>") -- for dev note
vim.keymap.set("n", "<A-t>", "<cmd>TransparentToggle<cr>") -- for global note
-- vim.keymap.set("n", "<C-c>", "<cmd>CellularAutomaton make_it_rain<cr>")
-- vim.keymap.set("n", "<C-x>", "<cmd>CellularAutomaton game_of_life<cr>")
-- vim.keymap.set("n", "<C-l>", "<cmd>CellularAutomaton scramble<cr>")
vim.keymap.set("i", "<A-x>", "<Esc>dbxi")
vim.keymap.set("i", "<A-u>", "<Esc>uwi")
vim.keymap.set("n", "<A-l>", "<cmd>Gitsigns next_hunk<cr>")
vim.keymap.set({ "t", "n" }, "<A-x>", function()
    if vim.fn.mode() == "t" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
    else
        vim.api.nvim_feedkeys("i", "n", false)
    end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<C-w>", "<cmd>bd<CR>", { silent = true })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferPin<cr>")
vim.keymap.set("n", "<leader>yy", "<cmd>%y<cr>")
vim.keymap.set(
    "n",
    "<leader>xs",
    "<cmd>call setqflist(sort(getqflist(), {i1, i2 -> bufname(i1.bufnr) == bufname(i2.bufnr) ? 0 : bufname(i1.bufnr) > bufname(i2.bufnr) ? 1 : -1}))<cr>"
)
vim.keymap.set("n", "<leader>xa", require("utils.custom_commands").add_current_file_to_qflist)
vim.keymap.set("n", "<leader>xd", require("utils.custom_commands").remove_opened_buffr)
vim.keymap.set("n", "<A-h>", "<cmd>Gitsigns prev_hunk<cr>")
vim.keymap.set("n", "<F5>", "<cmd>UndotreeToggle<cr>")
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>")
vim.keymap.set("n", "<leader>gk", "<cmd>Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "<leader>X", "<cmd>LazyExtras<cr>")
vim.keymap.set("n", "<leader>ts", "<cmd>Trouble lsp_references<cr>")
vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<cr>")
vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<cr>")
vim.keymap.set("n", "<A-s-l>", "<cmd>BufferMoveNext<cr>")
vim.keymap.set("n", "<A-s-h>", "<cmd>BufferMovePrevious<cr>")
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>cp", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose Our Version" })
vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose Their Version" })
vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose Both Versions" })
vim.keymap.set("n", "<leader>c0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose None" })
vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next Conflict" })
vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous Conflict" })
vim.keymap.set("n", "<leader>m", marks.print_mark_info, {
    desc = "Print mark location (file, row, col)",
})
