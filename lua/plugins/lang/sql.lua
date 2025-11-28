return {
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod", lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
        },
        cmd = {
            "DBUI",
            "DBUIToggle",
            "DBUIAddConnection",
            "DBUIFindBuffer",
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_use_nvim_notify = 1
        end,
    },
    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                per_filetype = { sql = { "dadbod" } },
                providers = {
                    dadbod = { name = "dadbod", module = "vim_dadbod_completion.blink" },
                },
            },
        },
    },
    -- {
    --
    --     "kndndrj/nvim-dbee",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    --     build = function()
    --         -- Install tries to automatically detect the install method.
    --         -- if it fails, try calling it with one of these parameters:
    --         --    "curl", "wget", "bitsadmin", "go"
    --         require("dbee").install("wget")
    --     end,
    --     config = function()
    --         require("dbee").setup(--[[optional config]])
    --     end,
    -- },
}
