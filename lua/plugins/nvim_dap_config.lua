local dap = require("dap")

-- Python Debugger configuration
require("dap-python").setup("python3")

dap.adapters.python = {
    type = "executable",
    command = "/usr/bin/python3", -- Path to python executable
    args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}", -- Program to debug (currently open file)
        pythonPath = function()
            return "/usr/bin/python3" -- Path to python executable
        end,
    },
}
