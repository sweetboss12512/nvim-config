local icons = require("config.icons")

return {
	-- (https://github.com/stevearc/oil.nvim)
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- enabled = false,
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
			lsp_file_methods = {
				-- Enable or disable LSP file operations
				enabled = true,
				-- Time to wait for LSP file operations to complete before skipping
				timeout_ms = 1000,
				-- Set to true to autosave buffers that are updated with LSP willRenameFiles
				-- Set to "unmodified" to only save unmodified buffers
				autosave_changes = true,
			},

			filesystem = {
				filtered_items = {
					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
					hide_dotfiles = false,
					hide_gitignored = true,
				},
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = false,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name, bufnr)
					-- return vim.startswith(name, ".")
					return false
				end,
				is_always_hidden = function(name, bufnr)
					return vim.startswith(name, ".git/") or vim.startswith(name, ".git\\")
				end,
			},
		})

		vim.keymap.set("n", "<leader>v", "<cmd>Oil<cr>", { desc = "Open Oil Explorer" })
		vim.keymap.set("n", "<leader>V", "<cmd>Oil .<cr>", { desc = "Open Oil Explorer (CWD)" })
	end,
}
