-- Put this in a file like `lua/utils/search.lua`
local M = {}

function M.find_large_number(num_str)
    -- Use a pcall to safely convert the string to a number
    local ok, target_number = pcall(tonumber, num_str)
    if not ok or target_number == nil then
        vim.notify("Invalid number: " .. num_str, vim.log.levels.ERROR)
        return
    end

    local qf_list = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    for lnum, line in ipairs(lines) do
        -- gmatch with "()" gives us the position (start column)
        for num_match, start_col in line:gmatch("(%d+)", "()", 1) do
            local num = tonumber(num_match)
            if num and num >= target_number then
                table.insert(qf_list, {
                    bufnr = bufnr,
                    lnum = lnum,
                    col = start_col,
                    text = line, -- Show the full line in quickfix
                })
            end
            break
        end
    end

    if #qf_list > 0 then
        vim.fn.setqflist(qf_list, "r", "Numbers >= " .. num_str)
        vim.cmd("copen")
        vim.notify("Found " .. #qf_list .. " matches.", vim.log.levels.INFO)
    else
        vim.notify("No numbers found >= " .. target_number, vim.log.levels.INFO)
    end
end

return M
