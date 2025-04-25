return {
    "Goose97/timber.nvim",
    -- version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    keys = {
        -- stylua: ignore start
        { "gld", function() require("timber.actions").clear_log_statements({ global = false }) end, desc = "Clear log statements" },
        { "glD", function() require("timber.actions").clear_log_statements({ global = true }) end, desc = "Clear log statements (Global)" },
        { "gls", function() require("timber.actions").search_log_statements() end, desc = "Search log statements" },
        -- stylua: ignore end
    },
    ---@type Timber.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        log_marker = "◉",
        keymaps = {
            -- Set to false to disable the default keymap for specific actions
            -- insert_log_below = false,
            insert_log_below = "glj",
            insert_log_above = "glk",
            insert_plain_log_below = "glo",
            insert_plain_log_above = "gl<S-o>",
            insert_batch_log = "glb",
            add_log_targets_to_batch = "gla",
            insert_log_below_operator = "gLj",
            insert_log_above_operator = "gLk",
            insert_batch_log_operator = "gLb",
            add_log_targets_to_batch_operator = "gLa",
        },
        log_templates = {
            default = {
                lua = [[print("%log_marker %log_target", %log_target)]],
                luau = [[print("%log_marker %log_target", %log_target)]],
            },
            plain = {
                lua = [[print("%log_marker %insert_cursor")]],
                luau = [[print("%log_marker %insert_cursor")]],
            },
        },
        batch_log_templates = {
            default = {
                lua = [[print(string.format("%log_marker %repeat<%log_target=%s><, >", %repeat<%log_target><, >))]],
                luau = [[print(`%log_marker %repeat<%log_target={%log_target}><, >`)]],
            },
        },
        plain = {
            lua = [[print("%log_marker %insert_cursor")]],
            luau = [[print("%log_marker %insert_cursor")]],
        },
    },
}
