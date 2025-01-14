local gitsigns_attach = function(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "Next git hunk" })

	map("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "Previous git hunk" })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Stage hunk" })
	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "Reset hunk" })
	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
	map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })

	map("n", "<leader>hb", function()
		gitsigns.toggle_current_line_blame()
	end, { desc = "Toggle current line blame" })
	map("n", "<leader>hB", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "Show line blame" })

	map("n", "<leader>hd", gitsigns.toggle_deleted, { desc = "Toggle git deleted" })
	-- map("n", "<leader>hD", gitsigns.diffthis, { desc = "Git diff file" }) -- I like fugitive's better
	map("n", "<leader>hl", gitsigns.toggle_linehl, { desc = "Toggle Line Highlight (GitSigns)" })

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<cr>")
end

return {
	{
		"tpope/vim-fugitive",
		-- lazy = false,
		cmd = "Git",
		keys = {
			{

				"<leader>gs",
				"<cmd>Git<cr>",
				desc = "Git Menu (Fugitive)",
			},
			{

				"<leader>G",
				"<cmd>Git<cr>",
				desc = "Git Interface (Fugitive)",
			},

			{

				"<leader>gc",
				"<cmd>Git commit | norm <C-w>K<cr>",
				desc = "Git Commit (Fugitive)",
			},

			{

				"<leader>ga",
				"<cmd>Git add %<cr>",
				desc = "Stage Current File (Fugitive)",
			},
			{

				"<leader>gA",
				"<cmd>Git add .<cr>",
				desc = "Stage Current File (Fugitive)",
			},
			{
				"<leader>gd",
				"<cmd>Gvdiffsplit<cr>",
				desc = "Git diff file",
			},
		},
		init = function()
			-- Allow for typing 'git' and be replaced with Git
			vim.cmd([[cnoreabbrev <expr> git ((getcmdtype() == ':' && getcmdline() == 'git') ? 'Git' : 'git')]])
			vim.cmd([[cnoreabbrev <expr> g ((getcmdtype() == ':' && getcmdline() == 'g') ? 'Git' : 'g')]])
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = gitsigns_attach,
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged_enable = true,
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		-- enabled = false,
		version = "*",
		opts = {
			default_mappings = {
				ours = "o",
				theirs = "t",
				none = "0",
				both = "b",
				next = "n",
				prev = "p",
			},
			default_commands = true, -- disable commands created by this plugin
			disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
			list_opener = "Trouble quickfix", -- command or function to open the conflicts list
			highlights = { -- They must have background color, otherwise the default color will be used
				incoming = "DiffAdd",
				current = "DiffText",
			},
		},
	},
	{
		"sindrets/diffview.nvim",
		enabled = false,
		opts = {},
	},
}
