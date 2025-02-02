return {
    {
        "echasnovski/mini.icons",
        opts = {
            file = {
                ["README.md"] = { glyph = "", hl = "MiniIconsCyan" },
            },
            lsp = require("config.icons").kind,
        },
        lazy = true,
        specs = {
            { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
        },
        init = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
}
