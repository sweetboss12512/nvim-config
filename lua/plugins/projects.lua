return {
	"ahmedkhalf/project.nvim",
	keys = {
		{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Recent Projects (Telescope)" },
	},
	lazy = false,
	enabled = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("project_nvim").setup({
			patterns = { ".git", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
			detection_methods = { "pattern" },
		})

		require("telescope").load_extension("projects")
	end,
}
