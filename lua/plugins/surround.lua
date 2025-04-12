return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
        keymaps = {

            -- #region Defaults
            insert = "<C-g>s",
            insert_line = "<C-g>S",
            normal = "ys",
            normal_cur = "yss",
            normal_line = "yS",
            normal_cur_line = "ySS",
            visual = "S",
            visual_line = "gS",
            delete = "ds",
            change = "cs",
            change_line = "cS",
            --#endregion

            -- helix-like: Mainly wanted to map multicursor split to 'v_S'
            -- insert = "<C-g>s",
            -- insert_line = "<C-g>S",
            -- normal = "ms",
            -- normal_cur = "mss",
            -- normal_line = "mS",
            -- normal_cur_line = "mSS",
            -- visual = "ms",
            -- visual_line = "gS",
            -- delete = "md",
            -- change = "mr",
            -- change_line = "mS",
        },
    },
}
