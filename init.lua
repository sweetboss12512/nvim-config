-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.cmd("set termguicolors")

require("lazy_setup")
require("options")
require("keymaps")
require("autocmd")
require("filetypes")
require("commands")

if not vim.g.vscode then
	vim.cmd.colorscheme("everforest") -- catppuccin-mocha
	-- vim.cmd.colorscheme("rose-pine") -- catppuccin-mocha
end

-- if #vim.v.argv < 3 and not vim.g.vscode then -- Only load the session when no arguments were passed...
-- 	vim.cmd(":OpenSession")
-- end

-- if vim.g.neovide then
-- 	vim.cmd.cd("$HOME") -- This is stupid
-- end
