return {
	{
		"numToStr/Comment.nvim",
		event = "BufRead",
		opts = {
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = { line = "gcc", block = "gbc" },
			opleader = { line = "gc", block = "gb" },
			extra = { above = "gcO", below = "gco", eol = "gA" },
			mappings = { basic = true, extra = true },
			pre_hook = nil,
			post_hook = nil,
		},
	},
}
