return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = vim.g.vscode == nil,
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					".git/",
					".git\\",
					".cache",
					-- "%.exe",
					"node_modules",
					-- "venv",
					-- ".venv",
					"__pycache__",
					"%.o",
					"%.a",
					"%.out",
					"%.class",
					"%.pdf",
					"%.mkv",
					"%.mp4",
					"%.zip",
				},
			},
		})

		local builtin = require("telescope.builtin")
		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", function()
			builtin.find_files({ hidden = true, no_ignore = true })
		end, { desc = "Files (Telescope)" })
		keymap("n", "<leader>fb", builtin.buffers, { desc = "Buffers (Telescope)" })
		keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep (Telescope)" })
		keymap("n", "<leader>fh", builtin.help_tags, { desc = "Help Pages (Telescope)" })
		keymap("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document Symbols (Telescope)" })
	end,
}
