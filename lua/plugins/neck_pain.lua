return {
	"shortcuts/no-neck-pain.nvim",
	lazy = false,
	keys = {
		{
			"<leader>|",
			"<cmd>NoNeckPain<cr>",
			desc = "No Neck Pain (Toggle)",
		},
		{
			"<leader>nl",
			"<cmd>NoNeckPainToggleRightSide<cr>",
			desc = "No Neck Pain (Toggle)",
		},
	},
	opts = {
		-- width = 120,
		width = 100,
		buffers = {
			right = {
				enabled = false,
			},
			wo = {
				fillchars = "eob: ",
			},
		},
	},
}
