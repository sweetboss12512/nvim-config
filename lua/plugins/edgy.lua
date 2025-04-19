return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    -- enabled = false,
    keys = {
        {
            "<leader>ue",
            function()
                require("edgy").toggle()
            end,
            desc = "Edgy Toggle",
        },
      -- stylua: ignore
      { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
    },
    opts = function()
        ---@type Edgy.Config
        local opts = {
            options = {
                left = { size = 0.26 },
            },
            animate = { enabled = false },
            bottom = {
                { ft = "snacks_terminal", title = "Terminal" },
                {
                    title = "Quickfix",
                    ft = "qf",
                    filter = function(_, win)
                        return vim.fn.getwininfo(win)[1]["loclist"] ~= 1
                    end,
                },
                {
                    title = "Location List",
                    ft = "qf",
                    filter = function(_, win)
                        return vim.fn.getwininfo(win)[1]["loclist"] == 1
                    end,
                },
            },
            left = {
                { ft = "trouble", size = {} },
                { ft = "dbui" },
                { ft = "undotree" },
                {
                    ft = "gitsigns-blame",
                },
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "filesystem"
                    end,
                },
            },

            right = {
                { title = "Grug Far", ft = "grug-far", size = { width = 0.35 } },
                {
                    title = "Overseer",
                    ft = "OverseerList",
                    open = function()
                        require("overseer").open()
                    end,
                },
            },
        }

        -- snacks terminal
        for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
            opts[pos] = opts[pos] or {}
            table.insert(opts[pos], {
                ft = "snacks_terminal",
                -- size = { height = 0.8 },
                title = "%{b:snacks_terminal.id}: %{b:term_title}",
                filter = function(_, win)
                    return vim.w[win].snacks_win
                        and vim.w[win].snacks_win.position == pos
                        and vim.w[win].snacks_win.relative == "editor"
                        and not vim.w[win].trouble_preview
                end,
            })
        end

        return opts
    end,
}
