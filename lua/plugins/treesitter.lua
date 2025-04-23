return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = { enable = not vim.g.vscode, additional_vim_regex_highlighting = false },
            indent = { enable = true },
            endwise = { enable = true },
            ensure_installed = { "lua", "luau", "vim", "vimdoc", "query" },
            auto_install = true,

            textobjects = {
                -- stylua: ignore
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                },
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ic"] = "@comment.inner",
                        ["ac"] = "@comment.outer",
                        ["id"] = "@assignment.lhs",
                    },
                    include_surrounding_whitespace = false,
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
    { "RRethy/nvim-treesitter-endwise", event = "VeryLazy" },
    { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        keys = {
            {
                "[w",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                desc = "Current context (Treesitter)",
            },
        },
    },
    {
        "Wansmer/treesj",
        keys = {
            {
                "<leader>j",
                function()
                    require("treesj").toggle()
                end,
                desc = "Split or Join code block",
            },
        },
        config = function()
            local tsj = require("treesj")
            local tsj_utils = require("treesj.langs.utils")
            local lua = require("treesj.langs.lua")
            tsj.setup({
                use_default_keymaps = false,
                max_join_length = 1000,
                langs = {
                    luau = tsj_utils.merge_preset(lua, {
                        object_type = tsj_utils.set_preset_for_dict(),
                    }),
                },
            })
        end,
    },
    {
        "kiyoon/treesitter-indent-object.nvim",
        opts = {},
        keys = {
            {
                "ai",
                function()
                    require("treesitter_indent_object.textobj").select_indent_outer()
                end,
                mode = { "x", "o" },
                desc = "Select context-aware indent (outer)",
            },
            {
                "aI",
                function()
                    require("treesitter_indent_object.textobj").select_indent_outer(true)
                end,
                mode = { "x", "o" },
                desc = "Select context-aware indent (outer, line-wise)",
            },
            {
                "ii",
                function()
                    require("treesitter_indent_object.textobj").select_indent_inner()
                end,
                mode = { "x", "o" },
                desc = "Select context-aware indent (inner, partial range)",
            },
            {
                "iI",
                function()
                    require("treesitter_indent_object.textobj").select_indent_inner(true, "V")
                end,
                mode = { "x", "o" },
                desc = "Select context-aware indent (inner, entire range) in line-wise visual mode",
            },
        },
    },
}
