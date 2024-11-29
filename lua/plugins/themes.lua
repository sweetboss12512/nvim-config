return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		opts = {
			no_italic = true,
			color_overrides = {
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
		},
	},
	{
		"savq/melange-nvim",
		config = function()
			vim.g.melange_enable_font_variants = 0
		end,
	},
	{
		"neanias/everforest-nvim",
		name = "everforest",
		config = function()
			require("everforest").setup({
				background = "hard",
				---How much of the background should be transparent. 2 will have more UI
				---components be transparent (e.g. status line background)
				transparent_background_level = 0,
				---Whether italics should be used for keywords and more.
				italics = false,
				---Disable italic fonts for comments. Comments are in italics by default, set
				---this to `true` to make them _not_ italic!
				disable_italic_comments = true,
				---By default, the colour of the sign column background is the same as the as normal text
				---background, but you can use a grey background by setting this to `"grey"`.
				sign_column_background = "none",
				---The contrast of line numbers, indent lines, etc. Options are `"high"` or
				---`"low"` (default).
				ui_contrast = "high",
			})
		end,
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			local colors = require("ayu.colors")
			colors.generate(false) -- Pass `true` to enable mirage

			require("ayu").setup({
				overrides = {
					-- ["@property"] = { fg = "#bfbdb6" },
					["@property.json"] = { fg = colors.func },
					Comment = { fg = colors.comment },
					LineNr = { fg = colors.fg },
				},
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "auto", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				extend_background_behind_borders = true,

				enable = {
					terminal = true,
					legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},

				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},

				groups = {
					border = "muted",
					link = "iris",
					panel = "surface",

					error = "love",
					hint = "iris",
					info = "foam",
					note = "pine",
					todo = "rose",
					warn = "gold",

					git_add = "foam",
					git_change = "rose",
					git_delete = "love",
					git_dirty = "rose",
					git_ignore = "muted",
					git_merge = "iris",
					git_rename = "pine",
					git_stage = "iris",
					git_text = "rose",
					git_untracked = "subtle",

					h1 = "iris",
					h2 = "foam",
					h3 = "rose",
					h4 = "gold",
					h5 = "pine",
					h6 = "foam",
				},

				highlight_groups = {
					-- Comment = { fg = "foam" },
					-- VertSplit = { fg = "muted", bg = "muted" },
				},
			})
		end,
	},

	{
		"vague2k/vague.nvim",
		opts = {
			transparent = false, -- don't set background
			style = {
				-- "none" is the same thing as default. But "italic" and "bold" are also valid options
				boolean = "none",
				number = "none",
				float = "none",
				error = "none",
				comments = "none",
				conditionals = "none",
				functions = "none",
				headings = "bold",
				operators = "none",
				strings = "none",
				variables = "none",

				-- keywords
				keywords = "none",
				keyword_return = "none",
				keywords_loop = "none",
				keywords_label = "none",
				keywords_exception = "none",

				-- builtin
				builtin_constants = "none",
				builtin_functions = "none",
				builtin_types = "none",
				builtin_variables = "none",
			},
			-- Override colors
			colors = {
				bg = "#1c1c1c",
				fg = "#cdcdcd",
				floatBorder = "#878787",
				line = "#282830",
				comment = "#646477",
				builtin = "#bad1ce",
				func = "#be8c8c",
				string = "#deb896",
				number = "#d2a374",
				property = "#c7c7d4",
				constant = "#b4b4ce",
				parameter = "#b9a3ba",
				visual = "#363738",
				error = "#d2788c",
				warning = "#e6be8c",
				hint = "#8ca0dc",
				operator = "#96a3b2",
				keyword = "#7894ab",
				type = "#a1b3b9",
				search = "#465362",
				plus = "#8faf77",
				delta = "#e6be8c",
			},
		},
	},
}
