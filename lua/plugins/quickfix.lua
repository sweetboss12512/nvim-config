return {
    "stevearc/quicker.nvim",
    ft = { "qf" },
    keys = {
        -- stylua: ignore start
        { "<leader>fq", function() require("quicker").toggle() end, desc = "Toggle quickfix" },
        { "<leader>fl", function() require("quicker").toggle({ loclist = true }) end, desc = "Toggle loclist" },
        -- stylua: ignore end
    },
    opts = {
        highlight = {
            load_buffers = false,
            lsp = true,
        },
        keys = {
            {
                ">",
                function()
                    require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                end,
                desc = "Expand quickfix context",
            },
            {
                "<",
                function()
                    require("quicker").collapse()
                end,
                desc = "Collapse quickfix context",
            },
        },
    },
}
