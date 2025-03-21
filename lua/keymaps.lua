require("dev.fold-textobjects")

vim.g.mapleader = " "

local keymap = vim.keymap.set

-- keymap("n", "<leader>v", vim.cmd.Ex)
keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "System clipboard register" })
keymap({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })
keymap({ "n", "v" }, "<M-p>", [["0p]], { desc = "Paste last yank" })
keymap("n", "<leader>c", "<cmd>%y +<cr>", { desc = "Copy file to system clipboard" })
keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down one" }) -- Thank you primagen
keymap("v", "K", ":m '>-2<cr>gv=gv", { desc = "Move line up one" })
keymap("n", "gp", "`[v`]", { desc = "Select pasted text" })
keymap("n", "<leader>/", "/\\V", { desc = "Raw Text Search" })
-- keymap("n", "<Esc>", "<cmd>noh<cr>") -- Remove search highlighting when escape is pressed
-- keymap("n", "<leader>fq", "<cmd>copen<cr>", { desc = "Open Quickfix" }) -- Replaced with quicker.nvim (lua/plugins/quickfix.lua)
keymap("n", "gC", "yy<cmd>normal gcc<CR>p", { desc = "Comment and paste line" })
keymap("v", "gC", "y<cmd>normal `[v`]gc<CR>p", { desc = "Comment and paste line" })
keymap("v", "<leader>;", ":s/\\%V", { desc = "Find and Replace in selection" }) -- This isn't the default :/
keymap("i", "<C-l>", "<esc>A", { desc = "Move to end of line" }) -- This isn't the default :/

-- Centering cursor
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- Center cursor after jumping to a mark (https://stackoverflow.com/questions/59408739/how-to-bring-the-marker-to-middle-of-the-screen)
vim.cmd([[nnoremap <expr> ' "'" . nr2char(getchar()) . 'zz']])
vim.cmd([[nnoremap <expr> ' "'" . nr2char(getchar()) . 'zz']])

-- Select line
keymap("o", "il", ":<c-u>normal! $v^<cr>", { silent = true })
keymap("x", "il", ":<c-u>normal! $v^<cr>", { silent = true })

-- Map Enter to :write
-- vim.cmd([[nnoremap <cr> <cmd>write<cr>]])
-- vim.cmd([[au CmdwinEnter * noremap <buffer> <CR> <CR>]])

keymap("n", "<leader>q", function()
    if vim.g.neovide then
        vim.cmd("bufdo bd")
    else
        vim.cmd("qa")
    end
end, { desc = "Quit NEOVIM" })

keymap("n", "]q", "<cmd>cn<cr><cmd>normal zz<cr>", { desc = "Next in Quickfix" })
keymap("n", "[q", "<cmd>cp<cr><cmd>normal zz<cr>", { desc = "Previous in Quickfix" })
-- keymap("n", "]w", "<cmd>lnext<cr><cmd>normal zz<cr>", { desc = "Next in LocList" })
-- keymap("n", "[w", "<cmd>lprevious<cr><cmd>normal zz<cr>", { desc = "Previous in LocList" })

-- Quick navigating buffers
keymap("n", "]b", "<cmd>bn<cr>", { desc = "Next Buffer" })
keymap("n", "[b", "<cmd>bp<cr>", { desc = "Previous Buffer" })
-- keymap("n", "<M-d>", "<cmd>bd<cr>")

-- Terminal
keymap("t", "<Esc>", "<C-\\><C-n>") -- This may cause some problems...?
-- keymap("n", "<leader>t", "<cmd>botright 15sp | term<cr>i")

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
