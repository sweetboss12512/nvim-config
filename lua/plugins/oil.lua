local icons = require("config.icons")

return {
	-- (https://github.com/stevearc/oil.nvim)
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- enabled = false,
	enabled = vim.g.vscode == nil,

	config = function()
		require("oil").setup({
			columns = {
				{
					"icon",
					default_file = icons.file,
					directory = icons.folder.close,
				},
			},
			default_file_explorer = true,
			delete_to_trash = true,

			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					-- return vim.startswith(name, ".")
					return true
				end,
				is_always_hidden = function(name, bufnr)
					return vim.startswith(name, ".git/") or vim.startswith(name, ".git\\")
				end,
			},
		})

		vim.keymap.set("n", "<leader>v", "<cmd>Oil<CR>", { desc = "Open Oil Explorer" })
	end,
}
