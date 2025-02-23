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
vim.opt.ssl = true

vim.opt.fillchars:append("eob: ") -- No more tidles!
vim.opt.path:append("**")

if vim.fn.has("win32") == 1 then
    vim.opt.keywordprg = ":help" -- No man :/

    if vim.fn.executable("bash.exe") then
        -- So many things need to be fixed
        -- See: (https://vi.stackexchange.com/questions/22869/how-can-neovim-on-windows-be-configured-to-use-gitbash-as-the-shell-without-brea)
        -- (https://vi.stackexchange.com/questions/34549/vim-usr-bin-bash-s-no-such-file-or-directory)
        vim.cmd([[
            let &shell='bash.exe'
            let &shellcmdflag = '-c'
            let &shellredir = '>%s 2>&1'
            set shellquote= shellxescape=
            " set noshelltemp
            set shellxquote=
            let &shellpipe='2>&1| tee'
            let $TMP="/tmp"
        ]])
    end
else
    vim.opt.shell = "bash"
end

-- vim.termguicolors = true
vim.opt.mouse = "a"
vim.opt.guifont = "JetBrainsMono NF:h12.5"

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0.05
end

vim.cmd("packadd cfilter")

-- Conflicts with gitsigns :/
-- vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

if vim.g.vscode then
    vim.cmd("syntax off")
else
    vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=ro") -- Disable auto add comment
end
