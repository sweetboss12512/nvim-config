return {
	"rcarriga/nvim-notify",
	enabled = false,
	config = function()
		local notify = require("notify")
		notify.setup({
			render = "wrapped-compact",
		})

		vim.notify = notify
		vim.keymap.set("n", "<leader>fn", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "Notification History (Telescope)" })
	end,
}
