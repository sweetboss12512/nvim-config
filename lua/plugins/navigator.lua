return {
    "mrjones2014/smart-splits.nvim",
    keys = {
        {
            mode = { "n", "t" },
            "<A-h>",
            function()
                require("smart-splits").move_cursor_left()
            end,
        },
        {
            mode = { "n", "t" },
            "<A-j>",
            function()
                require("smart-splits").move_cursor_down()
            end,
        },
        {
            mode = { "n", "t" },
            "<A-k>",
            function()
                require("smart-splits").move_cursor_up()
            end,
        },
        {
            mode = { "n", "t" },
            "<A-l>",
            function()
                require("smart-splits").move_cursor_right()
            end,
        },
    },
}
