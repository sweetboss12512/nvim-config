vim.wo.relativenumber = true
vim.wo.number = true -- Show absolute line number at the cursor line

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.undodir = vim.fn.stdpath("state") .. "/undo" -- vim.fn.stdpath("state") .. "/.vim/undodir"
vim.opt.undofile = true
vim.o.exrc = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.cursorline = true
vim.o.mousemoveevent = true

-- vim.cmd([[let &shell='C:/Users/sweet/scoop/apps/git/current/bin/bash.exe']])
-- vim.cmd([[let &shellcmdflag = '-l']])

if vim.fn.has("win32") == 1 then
	vim.opt.shell = "cmd.exe"
else
	vim.opt.shell = "bash"
end

-- vim.termguicolors = true
vim.opt.mouse = "a"
vim.opt.guifont = "FiraCode Nerd Font Mono:h14"

if vim.g.vscode then
	vim.cmd("syntax off")
else
	vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=ro") -- Disable auto add comment
end
