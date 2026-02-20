return {
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
        keys = {
            {
                "<leader>gd",
                function()
                    local lib = require("diffview.lib")
                    if next(lib.views) == nil then
                        vim.cmd.DiffviewOpen()
                    else
                        vim.cmd.DiffviewClose()
                    end
                end,
                desc = "Git Diff (toggle)",
            },
        },
    },
}
