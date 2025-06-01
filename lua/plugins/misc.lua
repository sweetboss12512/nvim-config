return {
    "echasnovski/mini.misc",
    version = "*",
    init = function()
        -- Remove "Frame" Terminals like Wezterm have around Neovim
        require("mini.misc").setup_termbg_sync()
    end,
}
