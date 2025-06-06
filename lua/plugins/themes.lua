return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        opts = {
            no_italic = true,
            color_overrides = {
                mocha = {
                    -- base = "#000000",
                    -- mantle = "#000000",
                    -- crust = "#000000",
                },
            },
        },
    },
    {
        "savq/melange-nvim",
        config = function()
            vim.g.melange_enable_font_variants = 0
        end,
    },
    {
        "neanias/everforest-nvim",
        name = "everforest",
        config = function()
            require("everforest").setup({
                background = "hard",
                ---How much of the background should be transparent. 2 will have more UI
                ---components be transparent (e.g. status line background)
                transparent_background_level = 0,
                ---Whether italics should be used for keywords and more.
                italics = false,
                ---Disable italic fonts for comments. Comments are in italics by default, set
                ---this to `true` to make them _not_ italic!
                disable_italic_comments = true,
                ---By default, the colour of the sign column background is the same as the as normal text
                ---background, but you can use a grey background by setting this to `"grey"`.
                sign_column_background = "none",
                ---The contrast of line numbers, indent lines, etc. Options are `"high"` or
                ---`"low"` (default).
                ui_contrast = "high",
            })
        end,
    },
    {
        "Shatur/neovim-ayu",
        config = function()
            local colors = require("ayu.colors")
            colors.generate(false) -- Pass `true` to enable mirage

            require("ayu").setup({
                overrides = {
                    -- ["@property"] = { fg = "#bfbdb6" },
                    ["@property.json"] = { fg = colors.func },
                    Comment = { fg = colors.comment },
                    LineNr = { fg = colors.fg },
                },
            })
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            variant = "auto", -- auto, main, moon, or dawn
            dark_variant = "main", -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                migrations = true, -- Handle deprecated options automatically
            },

            styles = {
                bold = true,
                italic = false,
                transparency = false,
            },

            groups = {
                border = "muted",
                link = "iris",
                panel = "surface",

                error = "love",
                hint = "iris",
                info = "foam",
                note = "pine",
                todo = "rose",
                warn = "gold",

                git_add = "foam",
                git_change = "rose",
                git_delete = "love",
                git_dirty = "rose",
                git_ignore = "muted",
                git_merge = "iris",
                git_rename = "pine",
                git_stage = "iris",
                git_text = "rose",
                git_untracked = "subtle",

                h1 = "iris",
                h2 = "foam",
                h3 = "rose",
                h4 = "gold",
                h5 = "pine",
                h6 = "foam",
            },

            highlight_groups = {
                -- Comment = { fg = "foam" },
                -- VertSplit = { fg = "muted", bg = "muted" },
                TroubleCount = { bg = "iris", fg = "base" },
                ["@comment.documentation"] = { fg = "iris" },
            },
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
        opts = function()
            local palette = require("gruvbox").palette
            return {
                -- contrast = "hard",
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                palette_overrides = {
                    -- bright_red = "#e67e80",
                },
                overrides = {
                    SignColumn = {
                        -- bg = "#282828",
                        bg = palette.dark0,
                    },
                    FzfLuaHeaderText = { fg = palette.bright_green },
                    GruvboxYellowSign = { bg = palette.dark0 },
                    GruvboxPurpleSign = { bg = palette.dark0 },
                    GruvboxOrangeSign = { bg = palette.dark0 },
                    GruvboxGreenSign = { bg = palette.dark0 },
                    GruvboxBlueSign = { bg = palette.dark0 },
                    GruvboxAquaSign = { bg = palette.dark0 },
                    GruvboxRedSign = { bg = palette.dark0 },
                    ["@markup.heading.2"] = { link = "GruvboxAquaBold" },
                    ["@markup.heading.3"] = { link = "GruvboxYellowBold" },
                    ["@markup.heading.4"] = { link = "GruvboxOrangeBold" },
                    ["@markup.heading.5"] = { link = "GruvboxPurpleBold" },
                },
            }
        end,
    },
    {
        "EdenEast/nightfox.nvim", -- lazy
    },
}
