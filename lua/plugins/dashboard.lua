local LOGO = [[
 ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. 
•█▌▐█▀▄.▀· ▄█▀▄ ▪█·█▌██ ·██ ▐███▪
▐█▐▐▌▐▀▀▪▄▐█▌.▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·
██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌
▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀
]]
local VERSION = vim.version()

local alpha = {
	"goolord/alpha-nvim",
	dependencies = {
		"echasnovski/mini.icons",
		{ "ahmedkhalf/project.nvim", lazy = false },
	},
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = vim.split(LOGO, "\n")

		dashboard.section.buttons.val = {
			dashboard.button(
				"o",
				"  > Restore last session",
				":lua require('resession').load(require('util').get_git_branch())<CR>"
			),
			dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("e", "  > Browse files", ":Oil --float<CR>"),
			dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
			dashboard.button("p", "󰈞  > Projects (Telescope)", ":Telescope projects<CR>"),
			dashboard.button(
				"s",
				"  > Edit Configuration",
				":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"
			),
			dashboard.button("q", "  > Quit NEOVIM", ":qa<CR>"),
		}
		dashboard.section.footer.val = {
			"v" .. VERSION.major .. "." .. VERSION.minor .. "." .. VERSION.patch,
		}

		require("alpha").setup(dashboard.config)

		-- Open dashboard after closing lazy
		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end

		require("project_nvim").setup({
			patterns = { ".git", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
			detection_methods = { "pattern" },
		})
	end,
}

return {
	alpha,
}
