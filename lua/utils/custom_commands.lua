-- Creates a command `:CommentQfList`
local M = {}

function M.comment_or_leave_qflist()
    local qf_list = vim.fn.getqflist()
    if #qf_list == 0 then
        vim.notify("Quickfix list is empty.", vim.log.levels.WARN)
        return
    end

    -- Save the window we are currently in, so we can return to it.
    local original_win_id = vim.api.nvim_get_current_win()
    local processed_lines = {}
    local lines_processed = 0

    vim.cmd.undojoin()

    for _, item in ipairs(qf_list) do
        if item.valid == 1 then
            local bufnr = item.bufnr
            local lnum = item.lnum
            local processed_key = bufnr .. ":" .. lnum

            if not processed_lines[processed_key] then
                vim.cmd.undojoin()

                -- Find a window that contains the target buffer
                local target_win_id = vim.fn.bufwinid(bufnr)

                -- Only proceed if the buffer is actually visible in a window
                if target_win_id ~= -1 then
                    -- Switch to the target window
                    vim.api.nvim_set_current_win(target_win_id)

                    -- Execute the command. The 'gcc' command from Comment.nvim is
                    -- line-wise, so we just need to go to the line and run it.
                    -- :[line number] | normal! gcc
                    local command_string = string.format("%ds/^/\\/\\/", lnum)
                    vim.cmd(command_string)

                    lines_processed = lines_processed + 1
                end
                processed_lines[processed_key] = true
            end
        end
    end

    -- IMPORTANT: Switch back to the window where we started.
    vim.api.nvim_set_current_win(original_win_id)

    vim.notify("Processed " .. lines_processed .. " line(s) from the quickfix list.", vim.log.levels.INFO)
end

function M.dump_files_in_one()
    local qf_list = vim.fn.getqflist()
    local seen_files = {}
    local output_lines = {}

    for _, item in ipairs(qf_list) do
        local bufnr = item.bufnr

        -- Check if buffer is valid and hasn't been processed yet
        if bufnr and bufnr > 0 and not seen_files[bufnr] then
            local filename = vim.api.nvim_buf_get_name(bufnr)

            -- Ensure filename is not empty
            if filename ~= "" then
                seen_files[bufnr] = true

                -- Get absolute path
                local abs_path = vim.fn.fnamemodify(filename, ":p")

                -- 1. Insert Absolute Path (Commented with #)
                table.insert(output_lines, "# " .. abs_path)

                -- 2. Read File Content
                -- We check if file is readable on disk
                if vim.fn.filereadable(filename) == 1 then
                    local lines = vim.fn.readfile(filename)
                    for _, line in ipairs(lines) do
                        table.insert(output_lines, line)
                    end
                else
                    table.insert(output_lines, "[Error: Could not read file content]")
                end

                -- 3. Insert Separator
                table.insert(output_lines, "---")
            end
        end
    end

    if #output_lines == 0 then
        vim.notify("Quickfix list is empty or contains no valid files.", vim.log.levels.WARN)
        return
    end

    -- Create a new scratch buffer in a vertical split
    vim.cmd("vnew")
    local new_buf = vim.api.nvim_get_current_buf()

    -- Set the lines
    vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, output_lines)

    -- Optional: Set filetype to markdown for better highlighting of the structure
    -- (Since # is a header and --- is a horizontal rule in MD)
    vim.bo[new_buf].filetype = "markdown"

    -- Make it a scratch buffer (not associated with a file)
    vim.bo[new_buf].buftype = "nofile"
    vim.bo[new_buf].bufhidden = "hide"
    vim.bo[new_buf].swapfile = false
end

function M.remove_buffr_from_qflist(num_str)
    local ok, target_number = pcall(tonumber, num_str)
    if not ok or target_number == nil then
        vim.notify("Invalid number: " .. num_str, vim.log.levels.ERROR)
        return
    end

    local qf = vim.fn.getqflist()
    table.remove(qf, target_number) -- Lua is 1-based
    vim.fn.setqflist(qf, "r")
end

function M.add_current_file_to_qflist()
    local file = vim.fn.expand("%:p")

    -- Handle Diffview virtual paths
    if file:match("^diffview://") then
        -- Strip the "diffview://<repo>/.git/<object-id>/" prefix
        local stripped = file:match("^diffview://.*/%.git/[^/]+/(.*)$")
        if stripped and stripped ~= "" then
            -- Prepend git root to make a usable absolute path
            local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or ""
            if git_root ~= "" then
                file = git_root .. "/" .. stripped
            else
                file = stripped
            end
        end
    end

    -- Guard: ensure file is non-empty
    if file == "" then
        return
    end

    -- Add to quickfix at line 1, column 1
    vim.fn.setqflist({
        {
            filename = file,
            lnum = 1,
            col = 1,
            text = file,
        },
    }, "a")
end

function M.remove_opened_buffr()
    local qf_list = vim.fn.getqflist()
    local current_line_number = vim.fn.line(".")

    if qf_list[current_line_number] then
        -- Remove the item from the Lua table
        table.remove(qf_list, current_line_number)
        -- Replace the old quickfix list with the new one
        vim.fn.setqflist(qf_list, "r")
        -- Move the cursor to the correct position in the modified list
        local new_line_number = math.min(current_line_number, #qf_list)
        vim.fn.cursor(new_line_number, 1)
    end
end

return M
