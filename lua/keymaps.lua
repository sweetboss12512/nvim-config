vim.g.mapleader = " "

local keymap = vim.keymap.set

-- keymap("n", "<leader>v", vim.cmd.Ex)
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "System clipboard register" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap("n", "<leader>c", "<cmd>%y +<cr>", { desc = "Copy file to system clipboard" })
keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down one" }) -- Thank you primagen
keymap("v", "K", ":m '>-2<cr>gv=gv", { desc = "Move line up one" })
keymap("n", "gp", "`[v`]")
keymap("n", "<leader>/", "/\\V", { desc = "Raw Text Search" })
keymap("n", "<Esc>", "<cmd>noh<cr>") -- Remove search highlighting when escape is pressed
-- keymap("n", "<leader>fq", "<cmd>copen<cr>", { desc = "Open Quickfix" })

-- Centering cursor
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Center cursor after jumping to a mark (https://stackoverflow.com/questions/59408739/how-to-bring-the-marker-to-middle-of-the-screen)
vim.cmd([[nnoremap <expr> ' "'" . nr2char(getchar()) . 'zz']])
vim.cmd([[nnoremap <expr> ' "'" . nr2char(getchar()) . 'zz']])

keymap("n", "<leader>q", function()
	if vim.g.neovide then
		vim.cmd("bufdo bd")
	else
		vim.cmd("qa")
	end
end)

keymap("n", "]q", "<cmd>cn<cr>", { desc = "Next in Quickfix" })
keymap("n", "[q", "<cmd>cp<cr>", { desc = "Previous in Quickfix" })

-- Quick navigating buffers
keymap("n", "]b", "<cmd>bn<cr>", { desc = "Next Buffer" })
keymap("n", "[b", "<cmd>bp<cr>", { desc = "Previous Buffer" })
keymap("n", "<A-d>", "<cmd>bd<cr>")

-- Terminal
keymap("t", "<Esc>", "<C-\\><C-n>") -- This may cause some problems...?
-- keymap("n", "<leader>t", "<cmd>botright 15sp | term<cr>i")

-- Empty buffer on new split
vim.keymap.set("n", "<C-w>v", "<cmd>vnew<cr><C-w>L") -- Always on the right side of the screen
vim.keymap.set("n", "<C-w>s", "<cmd>new<cr>")

if vim.g.vscode then
	local vscode = require("vscode")

	---@param command string
	local function call_wrap(command)
		return function()
			vscode.call(command)
		end
	end

	keymap("n", "<leader>ff", call_wrap("workbench.action.quickOpen"))
	keymap("n", "<leader>fw", call_wrap("workbench.action.findInFiles"))
	keymap("n", "\\", call_wrap("workbench.action.toggleSidebarVisibility"))
	keymap("n", "<leader>t", call_wrap("workbench.action.terminal.toggleTerminal"))
	keymap("n", "gx", call_wrap("editor.action.openLink"))
	keymap("n", "gf", call_wrap("editor.action.openLink"))
	keymap("n", "fg", call_wrap("workbench.view.search"))

	-- VScode Harpoon
	keymap("n", "<leader>a", call_wrap("vscode-harpoon.addEditor"))
	keymap("n", "<leader>e", call_wrap("vscode-harpoon.editEditors"))

	keymap("n", "<leader>1", call_wrap("vscode-harpoon.gotoEditor1"))
	keymap("n", "<leader>2", call_wrap("vscode-harpoon.gotoEditor2"))
	keymap("n", "<leader>3", call_wrap("vscode-harpoon.gotoEditor3"))
	keymap("n", "<leader>4", call_wrap("vscode-harpoon.gotoEditor4"))
	keymap("n", "<leader>5", call_wrap("vscode-harpoon.gotoEditor5"))

	-- Fix folding, but moving past folds still broken :/
	keymap("n", "za", call_wrap("editor.toggleFold"))
	keymap("n", "zR", call_wrap("editor.unfoldAll"))
	keymap("n", "zM", call_wrap("editor.foldAll"))
	keymap("n", "zo", call_wrap("editor.unfold"))
	keymap("n", "zO", call_wrap("editor.unfoldRecursively"))
	keymap("n", "zc", call_wrap("editor.fold"))
	keymap("n", "zC", call_wrap("editor.foldRecursively"))

	keymap("n", "z1", call_wrap("editor.foldLevel1"))
	keymap("n", "z2", call_wrap("editor.foldLevel2"))
	keymap("n", "z3", call_wrap("editor.foldLevel3"))
	keymap("n", "z4", call_wrap("editor.foldLevel4"))
	keymap("n", "z5", call_wrap("editor.foldLevel5"))
	keymap("n", "z6", call_wrap("editor.foldLevel6"))
	keymap("n", "z7", call_wrap("editor.foldLevel7"))

	-- LSP keybinds
	keymap("n", "]d", call_wrap("editor.action.marker.next"))
	keymap("n", "[d", call_wrap("editor.action.marker.prev"))

	-- "Trouble"
	keymap("n", "<leader>xx", call_wrap("workbench.actions.view.problems"))
end
