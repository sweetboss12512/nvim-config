return {
	"soulis-1256/eagle.nvim",
	enabled = false,
	config = function()
		vim.o.mousemoveevent = true
		require("eagle").setup({})
	end,
}
