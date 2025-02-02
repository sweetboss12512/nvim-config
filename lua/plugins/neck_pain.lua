return {
    "shortcuts/no-neck-pain.nvim",
    -- enabled = false,
    keys = {
        { "<leader>l", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain (Toggle)" },
        { "<leader>nl", "<cmd>NoNeckPainToggleRightSide<cr>", desc = "No neck pain right (Toggle)" },
    },
    opts = {
        -- width = 120,
        width = 100,
        buffers = {
            -- colors = {
            -- 	blend = -0.1,
            -- 	background = "rose-pine",
            -- },
            -- right = {
            -- 	enabled = false,
            -- },
            wo = {
                fillchars = "eob: ",
                -- fillchars = "eob: ,vert: ",
            },
        },
    },
}
