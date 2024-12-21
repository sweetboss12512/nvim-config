return {
	"catgoose/nvim-colorizer.lua",
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
}
