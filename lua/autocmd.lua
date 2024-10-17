vim.api.nvim_create_autocmd({ "WinEnter" }, { -- Mainly for having relative lines in hover windows
	callback = function()
		vim.cmd("set relativenumber")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
