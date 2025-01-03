return {
	{
		"catgoose/nvim-colorizer.lua",
		-- enabled = false,
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					"html",
					"css",
					"yaml",
					"yml",
					"lua",
					"luau",
					"javascript",
					-- css = { css = true },
					"css",
				},
			})
		end,
	},
	{ "nvzone/volt", lazy = true },

	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
	},
}
