local icons = require("config.icons")
return {
	"ibhagwan/fzf-lua",
	-- enabled = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
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
		keymap("n", "<leader>fw", fzf.live_grep_resume, { desc = "Live Grep (Fzf)" })
		keymap("n", "<leader>fW", fzf.grep_last, { desc = "Grep Last (Fzf)" })
		keymap("n", "<leader>fh", fzf.helptags, { desc = "Help Pages (Fzf)" })
		keymap("n", "<leader>fr", fzf.oldfiles, { desc = "Recent Files (Fzf)" })
		keymap("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "Document Symbols (Fzf)" })
		keymap("n", "<leader>fQ", fzf.quickfix_stack, { desc = "Document Symbols (Fzf)" })
		keymap("n", "<leader>fo", fzf.resume, { desc = "Resume Last Query (Fzf)" })
		keymap("i", "<C-l>", fzf.complete_file)

		fzf.register_ui_select()
		vim.api.nvim_create_user_command("Z", function() -- zoxide vim doesn't support fzf-lua :/
			fzf.fzf_exec("zoxide query -l", {
				prompt = "Zoxide Directory>",
				actions = {
					default = function(selected)
						vim.cmd("tcd " .. selected[1])
					end,
				},
			})
		end, {})
	end,
}
