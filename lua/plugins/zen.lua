return {
	"folke/zen-mode.nvim",
	-- enabled = false,
	keys = {
		{
			"<leader>l",
			"<cmd>ZenMode<cr>",
		},
	},
	opts = {
		window = {
			width = 120,
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		plugins = { gitsigns = { enabled = true } }, -- disables git signs
	},
}
