local icons = require("config.icons")

return {
	"akinsho/bufferline.nvim",
	enabled = false,
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				-- separator_style = "thick",
				separator_style = "slope",
				style_preset = {
					bufferline.style_preset.no_italic,
					bufferline.style_preset.no_bold,
				},
				offsets = {
					{
						-- filetype = "NvimTree",
						filetype = "neo-tree",
						-- text = "File Explorer",
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					-- local icon = level:match("error") and " " or " "
					local icon = level:match("error") and icons.diagnostics.error or icons.diagnostics.warn
					return " " .. icon .. count
				end,
			},
		})

		vim.cmd("colorscheme default") -- I don't know why, but this fixes the white spot on bufferline separator_style.
	end,
}
