return {
    "sweetboss12512/fold-textobjects.nvim",
    -- dir = "~/dev/fold-textobjects.nvim/",
    -- dev = true,
    keys = {
        {
            mode = { "o", "x" },
            "iz",
            function()
                require("fold-textobjects").inside_fold()
            end,
            desc = "inner fold",
        },
        {
            mode = { "o", "x" },
            "az",
            function()
                require("fold-textobjects").around_fold()
            end,
            desc = "outer fold",
        },
    },
}
