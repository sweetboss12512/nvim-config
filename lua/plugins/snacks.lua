local LOGO = [[
 ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. 
•█▌▐█▀▄.▀· ▄█▀▄ ▪█·█▌██ ·██ ▐███▪
▐█▐▐▌▐▀▀▪▄▐█▌.▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·
██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌
▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀
─────────────────────────────────
]]

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        keys = {
        -- stylua: ignore start
        { "<leader>fn", function() Snacks.notifier.show_history() end, desc = "Notification History (Snacks)" },

        { mode = { "x", "o" }, "ik", function()
            Snacks.scope.textobject()
        end, desc = "scope (Snacks)" },


        { "<M-d>", function() Snacks.bufdelete() end, { desc = "Delete Buffer (Snacks)" } },
        { "<M-D>", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers (Snacks)" } },

        -- terminal
        { "<M-/>", function() Snacks.terminal() end, { desc = "Open Terminal " } },
        { "<M-_>", function() Snacks.terminal() end, { desc = "Open Terminal" } },
        { mode = "t", "<M-/>", "<cmd>close<cr>", { desc = "Hide Terminal" } },
        { mode = "t", "<M-_>", "<cmd>close<cr>", { desc = "which_key_ignore" } },

        { mode = {"n", "t"}, "<C-/>", function() Snacks.terminal.open() end, { desc = "Open New Terminal" } },
        { mode = {"n", "t"}, "<C-_>", function() Snacks.terminal.open() end, { desc = "which_key_ignore" } },

            -- NOTE: Only missing FzfLua complete_path :/

            -- Snacks Picker
            --#region Snacks Picker
            -- { "<leader>ff", function() Snacks.picker.files() end,                               desc = "Files (Snacks)" },
            -- { "<leader>fw", function() Snacks.picker.grep() end,                                desc = "Live Grep (Snacks)" },
            -- { "<leader>fW", function() Snacks.picker.grep_word() end,                           desc = "Grep Word (Snacks)" },
            -- { "<leader>fb", function() Snacks.picker.buffers() end,                             desc = "Buffers (Snacks)" },
            -- { "<leader>fh", function() Snacks.picker.help() end,                                desc = "Help Pages (Snacks)" },
            -- { "<leader>fQ", function() Snacks.picker.qflist() end,                                desc = "Quckfix List (Snacks)" },
            -- { "<leader>fr", function() Snacks.picker.recent() end,                              desc = "Recent (Snacks)" },
            -- { "<leader>fo", function() Snacks.picker.resume() end,                              desc = "Resume Picker (Snacks)" },
            -- { "<leader>fd", function() Snacks.picker.zoxide() end,                              desc = "Zoxide Results (Snacks)" },
            -- { "<leader>fu",  function() Snacks.picker.explorer(({ finder = "diagnostics" })) end, desc = "Git Status (Snacks)" },
            -- { "\\",         function() Snacks.picker.explorer() end,                            desc = "Git Status (Snacks)" },
            --
            --
            -- { "<leader>gs", function() Snacks.picker.explorer(({ finder = "git_status" })) end, desc = "Git Status (Snacks)" },
            -- { "<leader>gb",  function() Snacks.picker.git_branches() end },
            -- { "<leader>gl",  function() Snacks.picker.git_log() end },
            --
            -- stylua: ignore end
            --#endregion
        },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = false },
            notifier = {
                enabled = true,
                style = "compact",
            },
            terminal = { enabled = true },

            indent = {
                enabled = true,
                -- char = "▎",
                -- animate = { enabled = false },
                -- Not sure how I feel about this...
                scope = {
                    -- enabled = false,
                    -- char = "▎",
                    underline = false,
                    only_current = false,
                    hl = "SnacksIndentScope",
                },
            },
            -- quickfile = { enabled = true },
            -- statuscolumn = { enabled = true },
            -- words = { enabled = true },
            picker = {
                enabled = false,
                layout = { preset = "telescope" },
                -- #region Modified telescope...
                -- layout = {
                --     preset = "telescope",
                --     reverse = true,
                --     layout = {
                --         box = "horizontal",
                --         backdrop = false,
                --         width = 0.8,
                --         height = 0.8,
                --         border = "none",
                --         {
                --             box = "vertical",
                --             { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                --             {
                --                 win = "input",
                --                 height = 1,
                --                 border = "rounded",
                --                 title = "{title} {live} {flags}",
                --                 title_pos = "center",
                --             },
                --         },
                --         {
                --             win = "preview",
                --             title = "{preview:Preview}",
                --             width = 0.45,
                --             border = "rounded",
                --             title_pos = "center",
                --         },
                --     },
                -- },
                -- #endregion
            },
            dashboard = {
                enabled = true,
                width = 60,
                row = nil,
                col = nil,
                pane_gap = 4,
                autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

                preset = {
                    pick = nil,
                    keys = {
                        {
                            icon = " ",
                            key = "o",
                            desc = "Restore Session",
                            action = ":lua require('resession').load(require('util').get_git_branch())",
                        },
                        { icon = " ", key = "f", desc = "Find File", action = ":FzfLua files" },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        {
                            icon = "󰒲 ",
                            key = "l",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },

                    header = LOGO,
                },
                formats = {
                    key = function(item)
                        return { { "[ ", hl = "special" }, { item.key, hl = "key" }, { " ]", hl = "special" } }
                    end,
                },
                sections = {
                    { section = "header" },
                    { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                    -- { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                    { section = "startup", icon = "" },
                },
                debug = false,
            },
        },
        init = function()
            print = function(...)
                local print_safe_args = {}
                local args = { ... }
                for i = 1, #args do
                    table.insert(print_safe_args, tostring(args[i]))
                end
                vim.notify(table.concat(print_safe_args, " "))
            end
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
            local function on_move(data)
                Snacks.rename.on_rename_file(data.source, data.destination)
            end
            local events = require("neo-tree.events")
            opts.event_handlers = opts.event_handlers or {}
            vim.list_extend(opts.event_handlers, {
                { event = events.FILE_MOVED, handler = on_move },
                { event = events.FILE_RENAMED, handler = on_move },
            })
        end,
    },
}
