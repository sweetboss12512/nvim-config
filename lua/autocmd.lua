-- vim.api.nvim_create_autocmd({ "WinEnter" }, { -- Mainly for having relative lines in hover windows
-- 	callback = function()
-- 		vim.cmd("set relativenumber")
-- 	end,
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Doesn't work :/
-- if vim.g.vscode then
-- 	vim.api.nvim_create_autocmd("BufRead", {
-- 		pattern = "vscodeHarpoon.harpoon",
-- 		callback = function(event)
-- 			-- vim.print(vim.inspect(event))
-- 			vim.keymap.set("n", "q", "<cmd>bd<cr>", { buffer = event.buf })
-- 			vim.keymap.set("n", "<Esc>", "<cmd>bd<cr>", { buffer = event.buf })
-- 		end,
-- 	})
-- end
