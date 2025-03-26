local auto_format = true

return {
    "stevearc/conform.nvim",
    lazy = false,
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                luau = { "stylua" },
                nix = { "alejandra" },
                python = { "black" },
                html = { "djlint" },
                jinja = { "djlint" },
                htmldjango = { "djlint" },
            },
            {
                format_on_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", { -- Auto format
            pattern = "*",
            callback = function(args)
                if auto_format then
                    require("conform").format({ bufnr = args.buf })
                end
            end,
        })

        vim.api.nvim_create_user_command("ToggleAutoFormat", function()
            auto_format = not auto_format
            vim.notify("Auto format set to " .. tostring(auto_format))
        end, {})

        vim.keymap.set("n", "<F3>", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end)
    end,
}
