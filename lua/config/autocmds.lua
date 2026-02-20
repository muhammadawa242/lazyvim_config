-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        vim.cmd("sleep 10m")
    end,
})

-- Create the custom command
vim.api.nvim_create_user_command("FindLargeNumber", function(opts)
    -- The function is defined in lua/utils/search.lua
    require("utils.search").find_large_number(opts.args)
end, {
    nargs = 1, -- This command requires one argument (the number)
    desc = "Find all numbers >= <number> and show in quickfix list",
})

vim.api.nvim_create_user_command("QfListComment", function(opts)
    require("utils.custom_commands").comment_or_leave_qflist()
end, { desc = "Comment out every line found in the quickfix list" })

vim.api.nvim_create_user_command("QfDump", function(opts)
    require("utils.custom_commands").dump_files_in_one()
end, { desc = "Dump all files in Quickfix list to a single buffer" })

vim.api.nvim_create_user_command("QfDeleteBuff", function(opts)
    require("utils.custom_commands").remove_buffr_from_qflist(opts.args)
end, {
    nargs = 1, -- This command requires one argument (the number)
    desc = "Delete buffer number from qflist",
})


-- vim.api.nvim_create_autocmd({ "VimLeave" }, {
--     callback = function()
--         vim.fn.jobstart('notify-send "hello"', { detach = true })
--     end,
-- })
