-- lua/utils/marks.lua
local M = {}

function M.print_mark_info()
    local mark = vim.fn.nr2char(vim.fn.getchar())
    local marks = vim.fn.getmarklist()

    -- Project root (LazyVim/root.nvim)
    local root = LazyVim.root.get()

    for _, m in ipairs(marks) do
        if m.mark == "'" .. mark then
            local row = m.pos[2]
            local col = m.pos[3]

            local file = m.file ~= "" and m.file or vim.api.nvim_buf_get_name(0)

            -- Make path relative to project root
            local rel = vim.fn.fnamemodify(file, ":." .. root)

            vim.fn.setreg("+", string.format("%s:%d:%d", file, row, col))

            print(string.format("mark [%s] → %s:%d:%d", mark, rel, row, col))
            return
        end
    end

    print("Mark [" .. mark .. "] not found")
end

return M
