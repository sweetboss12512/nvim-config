-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

-- Not in the mood of dealing with vscode potentially breaking, so just do everything by hand.
lazy.setup({
    spec = {
        { import = "plugins.treesitter" },
        { import = "plugins.vim_angry" },
        { import = "plugins.comments" },
        { import = "plugins.surround" },
        { import = "plugins.pairs" },
        { import = "plugins.timber" },
        { import = "plugins.multicursor" },
    },
})

require("options")
require("keymaps")
require("autocmd")
require("filetypes")
require("commands")
