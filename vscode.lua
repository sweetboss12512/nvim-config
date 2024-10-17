-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- require("lazy_setup")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

-- Not in the mood of dealing with vscode potentially breaking, so just do everything by hand.
lazy.setup({
	spec = {
		{ import = "plugins.treesitter" },
		{ import = "plugins.vim_angry" },
		{ import = "plugins.comment" },
		{ import = "plugins.surround" },
	},
})

require("options")
require("keymaps")
require("autocmd")
require("filetypes")

-- if not vim.g.vscode then
-- end

-- if #vim.v.argv < 3 and not vim.g.vscode then -- Only load the session when no arguments were passed...
-- 	vim.cmd(":OpenSession")
-- end

-- vim.diagnostic.config({ virtual_text = false })
