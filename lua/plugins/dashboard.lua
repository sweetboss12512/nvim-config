return {
	"goolord/alpha-nvim",
	dependencies = { "echasnovski/mini.icons" },
	enabled = true,
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			-- stylua: ignore start
[[ ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·.]],
[[•█▌▐█▀▄.▀· ▄█▀▄ ▪█·█▌██ ·██ ▐███▪]],
[[▐█▐▐▌▐▀▀▪▄▐█▌.▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·]],
[[██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌]],
[[▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀]],
			-- stylua: ignore end
		}

		dashboard.section.buttons.val = {
			dashboard.button(
				"o",
				"  > Restore last session",
				":lua require('resession').load(require('util').get_git_branch())<CR>"
			),
			dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("e", "  > Browse files", ":Oil --float<CR>"),
			dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
			-- dashboard.button("frr", "  > Recent", ":Telescope oldfiles<CR>"),
			dashboard.button(
				"s",
				"  > Edit Configuration",
				":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"
			),
			dashboard.button("q", "  > Quit NEOVIM", ":qa<CR>"),
		}

		require("alpha").setup(dashboard.config)
	end,
}
