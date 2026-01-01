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
    end,
}
