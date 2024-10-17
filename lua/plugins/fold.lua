-- Uhh folds that don't suck
return {
	"kevinhwang91/nvim-ufo",
	-- enabled = not vim.g.vscode,
	dependencies = { "kevinhwang91/promise-async" },
	opts = {
		provider_selector = function(bufnr, filetype, buftype)
			return { "treesitter", "indent" }
		end,
	},
}
