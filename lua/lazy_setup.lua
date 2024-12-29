local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.opt.rtp:prepend(lazypath)
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.g.mapleader = " "

local lazy = require("lazy")
lazy.setup({
	{ import = "plugins" },
	{ import = "plugins.lang" },
	-- {
	-- 	dir = "~/dev/session-wrapper.nvim/",
	-- },
})
