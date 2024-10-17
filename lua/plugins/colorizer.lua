return {
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*",
			"html",
			"css",
			"yaml",
			"yml",
			"lua",
			"luau",
			"javascript",
			css = { css = true },
		})
	end,
}
