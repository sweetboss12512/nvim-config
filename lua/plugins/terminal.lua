local nvterm = {
	"NvChad/nvterm",
	keys = {
		{
			"<leader>t",
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			desc = "Open Terminal",
		},
		{
			"<leader>T",
			function()
				require("nvterm.terminal").new("horizontal")
			end,
			desc = "Create New Terminal",
		},
		{
			"<A-i>",
			function()
				require("nvterm.terminal").toggle("float")
			end,
			desc = "Open Terminal (float)",
		},
	},
	config = function()
		require("nvterm").setup({
			terminals = {
				shell = vim.o.shell,
				list = {},
				type_opts = {
					float = {
						relative = "editor",
						row = 0.3,
						col = 0.25,
						width = 0.5,
						height = 0.4,
						border = "single",
					},
					horizontal = { location = "rightbelow", split_ratio = 0.3 },
					vertical = { location = "rightbelow", split_ratio = 0.5 },
				},
			},
			behavior = {
				autoclose_on_quit = {
					enabled = false,
					confirm = true,
				},
				close_on_exit = true,
				auto_insert = false,
			},
		})
	end,
}

return {
	nvterm,
	{
		"chomosuke/term-edit.nvim",
		event = "TermOpen",
		version = "1.*",
		opts = {
			prompt_end = "%$ ", -- bash
		},
	},
}
