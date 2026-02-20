return {
    "arminveres/md-pdf.nvim",
    branch = "main",
    lazy = true, -- load on demand
    keys = {
        {
            "<leader>;",
            function()
                require("md-pdf").convert_md_to_pdf()
            end,
            desc = "Markdown preview",
        },
    },
    opts = {}, -- you can configure options later
}
