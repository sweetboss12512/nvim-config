return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
        {
            "<F3>",
            function()
                require("conform").format()
            end,
            desc = "Foramt Buffer (Conform)",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            luau = { "stylua" },
            nix = { "alejandra" },
            python = { "black" },
            html = { "djlint" },
            jinja = { "djlint" },
            htmldjango = { "djlint" },
        },

        format_on_save = function()
            if vim.g.autoformat then
                return {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                }
            end
        end,
    },
    init = function()
        vim.g.autoformat = true
        vim.api.nvim_create_user_command("ToggleAutoFormat", function()
            vim.g.autoformat = not vim.g.autoformat
            vim.notify("Auto format set to " .. tostring(vim.g.autoformat))
        end, {})
    end,
}
