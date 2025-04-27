return {
    { "sweetboss12512/rbx-ui-autocomplete.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" }, lazy = true },
    { -- blink.cmp config
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "rbx_ui" },
                providers = {
                    rbx_ui = {
                        name = "RBX",
                        module = "rbx-ui-autocomplete",
                        ---@type rbx-ui.Config
                        opts = {
                            complete_snippets = {
                                completions = {
                                    UDim2 = "UDim2.fromScale($0)",
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
