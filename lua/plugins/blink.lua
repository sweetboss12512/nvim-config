local icons = require("config.icons")

local show_source_names = {
    "Omni",
    "RBX",
}
local completeShortcuts = {
    ["<M-1>"] = {
        function(cmp)
            cmp.accept({ index = 1 })
        end,
    },
    ["<M-2>"] = {
        function(cmp)
            cmp.accept({ index = 2 })
        end,
    },
    ["<M-3>"] = {
        function(cmp)
            cmp.accept({ index = 3 })
        end,
    },
    ["<M-4>"] = {
        function(cmp)
            cmp.accept({ index = 4 })
        end,
    },
    ["<M-5>"] = {
        function(cmp)
            cmp.accept({ index = 5 })
        end,
    },
    ["<M-6>"] = {
        function(cmp)
            cmp.accept({ index = 6 })
        end,
    },
    ["<M-7>"] = {
        function(cmp)
            cmp.accept({ index = 7 })
        end,
    },
    ["<M-8>"] = {
        function(cmp)
            cmp.accept({ index = 8 })
        end,
    },
    ["<M-9>"] = {
        function(cmp)
            cmp.accept({ index = 9 })
        end,
    },
    ["<M-0>"] = {
        function(cmp)
            cmp.accept({ index = 10 })
        end,
    },
}

return {
    {

        "saghen/blink.compat",
        -- enabled = false,
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = "*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },
    {
        "saghen/blink.cmp",
        -- enabled = false,
        dependencies = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
        },

        -- use a release tag to download pre-built binaries
        version = "v0.*",
        -- version = "v0.12.*",
        -- pin = true, -- No break unless i want to deal with it pls
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = "cargo build --release",
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            snippets = {
                preset = "luasnip",
            },
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = vim.tbl_extend("error", completeShortcuts, {
                preset = "super-tab",
            }),
            cmdline = {
                keymap = vim.tbl_extend("error", completeShortcuts, {
                    -- recommended, as the default keymap will only show and select the next item
                    ["<Tab>"] = { "show", "accept" },
                }),
                completion = { menu = { auto_show = true } },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
                kind_icons = icons.kind,
            },

            sources = {
                default = {
                    "lazydev",
                    "lsp",
                    "snippets",
                    "path",
                    "buffer",
                },
                per_filetype = { query = { "omni" } },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },
            completion = {
                accept = { auto_brackets = { enabled = false } },
                menu = {
                    border = "none",
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "item_idx", "seperator" },
                            { "kind_icon" },
                            { "label", "kind", "label_description", "source_name", gap = 1 },
                        },
                        components = {
                            item_idx = {
                                text = function(ctx)
                                    return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
                                end,
                                highlight = "comment",
                            },
                            source_name = {
                                text = function(ctx)
                                    return vim.tbl_contains(show_source_names, ctx.source_name) == true
                                            and ctx.source_name
                                        or ""
                                end,
                            },
                            seperator = {
                                text = function()
                                    return "│"
                                end,
                                highlight = "comment",
                            },
                        },
                    },
                },
                documentation = {
                    -- Controls whether the documentation window will automatically show when selecting a completion item
                    auto_show = true,
                    -- Delay before showing the documentation window
                    -- auto_show_delay_ms = 500,
                    auto_show_delay_ms = 0,
                    window = { border = "single" },
                },
            },
            signature = { enabled = true, window = { border = "single" } },
        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" },
        config = function(_, opts)
            require("blink-cmp").setup(opts)
            vim.keymap.set("i", "<C-n>", require("blink.cmp").show) -- have to do this manually :/
            vim.keymap.set("i", "<C-p>", require("blink.cmp").show)
        end,
    },
}
