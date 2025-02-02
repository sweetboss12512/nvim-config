return {
    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp", -- This is the regexp branch, use this for the new version
        keys = {
            { ",v", "<cmd>VenvSelect<cr>", desc = "Venv Selector (Python)" },
        },
        dependencies = {
            "neovim/nvim-lspconfig",
            -- "mfussenegger/nvim-dap",
            -- "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        -- lazy = false,
        config = function()
            require("venv-selector").setup({
                settings = {
                    options = {
                        debug = true,
                    },
                    search = {
                        my_venvs = {
                            command = "fd python$ $CWD",
                        },
                    },
                },

                name = {
                    "venv",
                    ".venv",
                },
            })
        end,
    },
}
