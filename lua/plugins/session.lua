local util = require("util")

return {
	"stevearc/resession.nvim",
	-- priority = 500000,
	lazy = false,
	config = function()
		local resession = require("resession")
		resession.setup({
			autosave = { enabled = false },
			dir = "sessions",
		})

		vim.keymap.set("n", "<leader>sw", function()
			local session_name = vim.fn.input("Session name: ")

			if string.len(session_name) == 0 then
				session_name = util.get_git_branch()
			end

			resession.save(session_name)
		end, { desc = "Save session" })

		vim.keymap.set("n", "<leader>so", function()
			resession.load(util.get_git_branch())
		end, { desc = "Restore last session" })
		vim.keymap.set("n", "<leader>sO", resession.load, { desc = "Restore Session (Manual)" })
		vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete session" })

		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	callback = function()
		-- 		-- Only load the session if nvim was started with no args
		-- 		if vim.fn.argc(-1) == 0 then
		-- 			resession.load(util.get_git_branch(), { dir = "dirsession", silence_errors = true })
		--
		-- 			vim.cmd("Gitsigns attach") -- Thse aren't being autoloaded for some reason?
		-- 			vim.cmd("UfoAttach")
		-- 		end
		-- 	end,
		-- })

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				resession.save(util.get_git_branch(), { notify = false })
			end,
		})
	end,
}
