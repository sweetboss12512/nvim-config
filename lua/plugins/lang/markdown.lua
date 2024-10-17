local renderMarkdown = {
	"MeanderingProgrammer/render-markdown.nvim",
	-- enabled = false,
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
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
	opts = {},
}

return {
	renderMarkdown,
	-- markview
}
