return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                -- 1. Configure Pyright for project-wide diagnostics
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                diagnosticMode = "workspace", -- Changed from "openFilesOnly"
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
                -- 2. Configure vtsls (TypeScript) for project-wide diagnostics
                vtsls = {
                    settings = {
                        typescript = {
                            tsserver = {
                                experimental = {
                                    enableProjectDiagnostics = true,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
