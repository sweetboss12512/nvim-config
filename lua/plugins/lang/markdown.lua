local renderMarkdown = {
	"MeanderingProgrammer/render-markdown.nvim",
	-- enabled = false,
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
	event = "BufEnter",
	opts = {
		enable = true,
	},
}

local markview = {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	branch = "v24.0.0",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		filetypes = { "markdown", "quarto", "rmd", "help" },
	},
}

return {
	renderMarkdown,
	-- markview,
}
