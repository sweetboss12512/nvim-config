return {
	"ibhagwan/fzf-lua",
	-- enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			"telescope",
		})

		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", function()
			fzf.files({ cwd_prompt = false })
		end, { desc = "Files (Fzf)" })
		keymap("n", "<leader>fb", fzf.buffers, { desc = "Buffers (Fzf)" })
		keymap("n", "<leader>fg", fzf.grep, { desc = "Live Grep (Fzf)" })
		keymap("n", "<leader>fh", fzf.helptags, { desc = "Help Pages (Fzf)" })
		keymap("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document Symbols (Fzf)" })
	end,
}
