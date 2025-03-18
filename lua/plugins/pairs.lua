return {
    {
        "windwp/nvim-autopairs",
        enabled = not vim.g.vscode,
        event = "InsertEnter",
        opts = {},
    },
    {
        "xzbdmw/clasp.nvim",
        keys = {
            {
                mode = { "n", "i" },
                "<M-l>",
                function()
                    require("clasp").wrap("next")
                end,
            },
            {
                mode = { "n", "i" },
                "<M-;>",
                function()
                    require("clasp").wrap("prev")
                end,
            },
        },
        opts = {},
    },
}
