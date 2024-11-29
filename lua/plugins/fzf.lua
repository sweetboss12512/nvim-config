return {
	"ibhagwan/fzf-lua",
	-- enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	--[[ keys = {
        {
		"<leader>fb", fzf.buffers, desc = "Buffers (Fzf)"
        },
        {
		"<leader>fg", fzf.grep, desc = "Live Grep (Fzf)"
        },
        {
		"<leader>fh", fzf.helptags, desc = "Help Pages (Fzf)"
        },
        {
		"<leader>fs", fzf.lsp_document_symbols, desc = "Document Symbols (Fzf)"
        },
        {
		"<leader>ff", 
			fzf.files({ cwd_prompt = false })
        },

	}, ]]
	config = function()
		local fzf = require("fzf-lua")
		fzf.setup({
			{ "telescope" },
			winopts = {--[[  fullscreen = true  ]]
			},
		})

		local keymap = vim.keymap.set

		keymap("n", "<leader>ff", function()
			fzf.files({ cwd_prompt = false })
		end, { desc = "Files (Fzf)" })
		keymap("n", "<leader>fb", fzf.buffers, { desc = "Buffers (Fzf)" })
		keymap("n", "<leader>fw", fzf.live_grep, { desc = "Live Grep (Fzf)" })
		keymap("n", "<leader>fW", fzf.grep_last, { desc = "Resume Live Grep (Fzf)" })
		keymap("n", "<leader>fh", fzf.helptags, { desc = "Help Pages (Fzf)" })
		keymap("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document Symbols (Fzf)" })

		-- keymap("i", "<C-x><C-f>", fzf.complete_file)
	end,
}
