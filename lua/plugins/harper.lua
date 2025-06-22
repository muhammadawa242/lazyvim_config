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
                    filetypes = { "markdown", "gitcommit", "lua", "python", "txt" },
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
            setup = {
                harper_ls = function(_, _)
                    -- Define the toggle keymap
                    vim.keymap.set("n", "<leader>uh", function()
                        local bufnr = vim.api.nvim_get_current_buf()
                        local active = false

                        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
                            if client.name == "harper_ls" then
                                vim.lsp.buf_detach_client(bufnr, client.id)
                                vim.b.harper_ls_disabled = true
                                vim.notify("Harper LS detached", vim.log.levels.INFO)
                                active = true
                                break
                            end
                        end
                        if not active then
                            vim.b.harper_ls_disabled = false
                            local lspconfig = require("lspconfig")
                            lspconfig.harper_ls.manager:try_add(bufnr)
                            vim.notify("Harper LS re-attached", vim.log.levels.INFO)
                        end
                    end, { desc = "Toggle Harper LS for this file" })

                    return false -- use default setup
                end,
            },
        },
    },
}
