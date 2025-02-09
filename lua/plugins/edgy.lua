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
        local opts = {
            animate = { enabled = false },
            bottom = {
                { ft = "qf", title = "Quickfix" },
                { ft = "snacks_terminal", title = "Terminal" },
            },
            left = {
                {
                    title = "Neo-Tree",
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "filesystem"
                    end,
                    size = { width = 0.24 },
                },
            },

            right = {
                { title = "Grug Far", ft = "grug-far", size = { width = 0.4 } },
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
