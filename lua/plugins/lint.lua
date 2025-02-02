return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            lua = { "selene" },
            luau = { "selene" },
        }

        vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "TextChanged" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
