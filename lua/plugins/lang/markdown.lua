local renderMarkdown = {
	"MeanderingProgrammer/render-markdown.nvim",
	-- enabled = false,
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
	event = "BufEnter",
	opts = {
		enable = true,
	},
}

-- local function extend_hl(name, def)
-- 	local current_def = vim.api.nvim_get_hl(0, { name = name })
-- 	local new_def = vim.tbl_extend("force", {}, current_def, def)
--
-- 	vim.api.nvim_set_hl(0, name, new_def)
-- 	return name
-- end

local markview = {
	"OXY2DEV/markview.nvim",
	lazy = false, -- Recommended
	branch = "v24.0.0",

	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		filetypes = { "markdown", "quarto", "rmd" },
		headings = {
			enable = true,

			--- Amount of character to shift per heading level
			---@type integer
			shift_width = 1,

			heading_1 = {
				style = "icon",

				shift_hl = "DiffAdd",

				--- Background highlight group.
				---@type string
				hl = "@markup.heading.1.markdown",
			},
			heading_2 = {
				hl = "@markup.heading.2.markdown",
			},
		},
	},
}

-- markdownH1     xxx cterm=bold gui=bold guifg=#c4a7e7
return {
	renderMarkdown,
	-- markview,
}
