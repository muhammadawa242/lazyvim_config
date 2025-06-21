return {
    -- Ensure harper_ls is installed via mason
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            vim.list_extend(opts.ensure_installed, { "harper_ls" })
        end,
    },

    -- Configure harper-ls with lspconfig
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                harper_ls = {
                    filetypes = { "markdown", "gitcommit", "lua", "python", "txt" }, -- extend as needed
                    settings = {
                        ["harper-ls"] = {
                            userDictPath = vim.fn.expand("~/.config/harper-ls/dict.txt"),
                            linters = {
                                spell_check = true,
                                sentence_capitalization = false,
                                repeated_words = true,
                            },
                            diagnosticSeverity = "hint",
                            codeActions = { forceStable = true },
                        },
                    },
                },
            },
        },
    },
}
