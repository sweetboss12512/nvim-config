vim.g.mapleader = " "

local keymap = vim.keymap.set

-- keymap("n", "<leader>v", vim.cmd.Ex)
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "System clipboard register" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap("n", "<leader>c", "mpggVG\"+y'pzz", { desc = "Copy file to system clipboard" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down one" }) -- Thank you primagen
keymap("v", "K", ":m '>-2<CR>gv=gv", { desc = "Move line up one" })
keymap("n", "gp", "`[v`]")
keymap("n", "<leader>/", "/\\V", { desc = "Raw Text Search" })
keymap("n", "<Esc>", "<cmd>noh<CR>") -- Remove search highlighting when escape is pressed

keymap("i", "<C-o>", "<ESC>O")

-- Centering cursor
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<leader>q", "<cmd>qa<CR>")
keymap("n", "]q", "<cmd>cn<CR>")
keymap("n", "[q", "<cmd>cp<CR>")

-- Terminal
keymap("t", "<Esc>", "<C-\\><C-n>") -- This may cause some problems...?
-- keymap("n", "<leader>t", "<cmd>botright 15sp | term<CR>i")

-- Empty buffer on new split
vim.keymap.set("n", "<C-w>v", "<cmd>vnew<CR><C-w>L") -- Always on the right side of the screen
vim.keymap.set("n", "<C-w>s", "<cmd>new<CR>")

if vim.g.vscode then
	local vscode = require("vscode")

	---@param command string
	local function callWrap(command)
		return function()
			vscode.call(command)
		end
	end

	keymap("n", "<leader>ff", callWrap("workbench.action.quickOpen"))
	keymap("n", "\\", callWrap("workbench.action.toggleSidebarVisibility"))
	keymap("n", "<leader>t", callWrap("workbench.action.terminal.toggleTerminal"))

	-- Harpoon
	keymap("n", "<leader>l", callWrap("vscode-harpoon.addEditor"))
	keymap("n", "<leader>e", callWrap("vscode-harpoon.editEditors"))

	keymap("n", "<leader>1", callWrap("vscode-harpoon.gotoEditor1"))
	keymap("n", "<leader>2", callWrap("vscode-harpoon.gotoEditor2"))
	keymap("n", "<leader>3", callWrap("vscode-harpoon.gotoEditor3"))
	keymap("n", "<leader>4", callWrap("vscode-harpoon.gotoEditor4"))
	keymap("n", "<leader>5", callWrap("vscode-harpoon.gotoEditor5"))

	-- Fix folding, but moving past folds still broken :/
	keymap("n", "za", callWrap("editor.toggleFold"))
	keymap("n", "zR", callWrap("editor.unfoldAll"))
	keymap("n", "zM", callWrap("editor.foldAll"))
	keymap("n", "zo", callWrap("editor.unfold"))
	keymap("n", "zO", callWrap("editor.unfoldRecursively"))
	keymap("n", "zc", callWrap("editor.fold"))
	keymap("n", "zC", callWrap("editor.foldRecursively"))

	keymap("n", "z1", callWrap("editor.foldLevel1"))
	keymap("n", "z2", callWrap("editor.foldLevel2"))
	keymap("n", "z3", callWrap("editor.foldLevel3"))
	keymap("n", "z4", callWrap("editor.foldLevel4"))
	keymap("n", "z5", callWrap("editor.foldLevel5"))
	keymap("n", "z6", callWrap("editor.foldLevel6"))
	keymap("n", "z7", callWrap("editor.foldLevel7"))

	-- LSP keybinds
	keymap("n", "]d", callWrap("editor.action.marker.next"))
	keymap("n", "[d", callWrap("editor.action.marker.prev"))
end
