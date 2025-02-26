return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },

        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local dap_python = require("dap-python")

            require("dapui").setup()
            require("dap-go").setup()

            dap_python.setup("python3")
            dap.adapters.go = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/dlv",
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }
            dap.adapters.codelldb = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                name = "codelldb",
            }

            -- require("nvim-dap-virtual-text").setup({
            --     commented = true, -- Show virtual text alongside comment
            -- })

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F7>", dap.continue)
            vim.keymap.set("n", "<F6>", dap.step_into)
            vim.keymap.set("n", "<leader>do", dap.step_over)
            vim.keymap.set("n", "<leader>dO", dap.step_out)
            vim.keymap.set("n", "<leader>du", dap.step_back)
            vim.keymap.set("n", "<leader>dr", dap.restart)
            vim.keymap.set("n", "<leader>dq", dap.terminate)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
