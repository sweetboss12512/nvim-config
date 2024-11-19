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
	enabled = false,
	dependencies = {
		"echasnovski/mini.icons",
	},
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = vim.split(LOGO, "\n")

		dashboard.section.buttons.val = {
			dashboard.button(
				"o",
				"  > Restore last session",
				":lua require('resession').load(require('util').get_git_branch())<cr>"
			),
			dashboard.button("n", "  > New file", ":ene <BAR> startinsert <cr>"),
			dashboard.button("r", " > Recent Files", ":FzfLua oldfiles<cr>"),
			dashboard.button("e", "  > Browse files", ":Oil --float<cr>"),
			dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<cr>"),
			dashboard.button("c", "  > Edit Configuration", ":tabedit $MYVIMRC | :tcd %:p:h | edit .<cr>"),
			dashboard.button("q", "  > Quit NEOVIM", ":qa<cr>"),
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
						vim.api.nvim_exec_autocmds("UIEnter", {--[[  group = "dashboard"  ]]
						})
					end)
				end,
			})
		end

		-- require("project_nvim").setup({
		-- 	patterns = { ".git", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
		-- 	detection_methods = { "pattern" },
		-- })
		-- vim.print("Pro", require("project_nvim").get_recent_projects())
	end,
}

return {
	alpha,
}
