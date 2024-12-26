return {
	"diniamo/run.nvim",
	-- enabled = false,
	opts = {
		-- Automatically save the current buffer before running the command.
		autosave = false,
		-- The format used for sending a notification before running a command,
		-- where %s represents the command (see lua's string.format). Set to nil
		-- to disable notifications. Eg. "$ %s"
		notification_format = nil,
		-- Disable number and relativenumber.
		disable_number = true,
		-- The percentage to darkness by, eg. 0.2 makes the terminal 20% darker,
		-- whereas -0.2 makes it 20% lighter. Set to false to disable.
		darken = 0.2,
		-- This is passed directly to `nvim_open_win` (see `:help nvim_open_win`),
		-- with the exception of row, column, width and height, which are used as
		-- percentages if between 0 and 1. Eg. 0.25 takes up 25% of Neovim's.
		-- width/height.
		winopts = {
			split = "below",
			height = 0.25,
		},
	},
	config = function(_, opts)
		local run = require("run")
		run.setup(opts)

		-- Runs the cached command
		vim.keymap.set("n", "<leader>ri", run.run)
		-- Prompts for a command, and overrides the cached one with it
		vim.keymap.set("n", "<leader>ro", function()
			run.run(nil, true)
		end)
		-- Prompts for a command to run, without overriding
		vim.keymap.set("n", "<leader>rc", function()
			local input = vim.fn.input("Run command: ")
			if input ~= "" then
				run.run(input, false)
			end
		end)
	end,
}
