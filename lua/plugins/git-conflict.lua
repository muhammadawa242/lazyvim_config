return {
    "akinsho/git-conflict.nvim",
    version = "*",
    opts = {
        -- Disables the default mappings so you can set your own
        default_mappings = false,
        -- Disables the default command list so you can set your own
        default_commands = true,
    },
    config = function(_, opts)
        require("git-conflict").setup(opts)

        -- It's recommended to set up your own keymaps
        vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose Our Version" })
        vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose Their Version" })
        vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose Both Versions" })
        vim.keymap.set("n", "<leader>c0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose None" })
        vim.keymap.set("n", "]x", "<cmd>GitConflictNextConflict<cr>", { desc = "Next Conflict" })
        vim.keymap.set("n", "[x", "<cmd>GitConflictPrevConflict<cr>", { desc = "Previous Conflict" })
    end,
}
