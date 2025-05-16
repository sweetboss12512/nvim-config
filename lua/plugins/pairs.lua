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
                "<M-;>",
                function()
                    if
                        vim.fn.mode() == "i"
                        and package.loaded["multicursor-nvim"]
                        and require("multicursor-nvim").numCursors() > 1
                    then
                        vim.cmd("stopinsert")
                    else
                        require("clasp").wrap("prev")
                    end
                end,
            },
        },
        opts = {},
    },
}
