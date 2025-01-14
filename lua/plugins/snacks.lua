local LOGO = [[
 ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. 
•█▌▐█▀▄.▀· ▄█▀▄ ▪█·█▌██ ·██ ▐███▪
▐█▐▐▌▐▀▀▪▄▐█▌.▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·
██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌
▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀
─────────────────────────────────
]]

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>fn",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History (Snacks)",
		},
	},
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		-- bigfile = { enabled = true },
		notifier = {
			enabled = true,
			style = "compact",
		},
		-- quickfile = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
		dashboard = {
			enabled = true,
			width = 60,
			row = nil,
			col = nil,
			pane_gap = 4,
			autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

			preset = {
				pick = nil,
				keys = {
					{
						icon = " ",
						key = "o",
						desc = "Restore Session",
						action = ":lua require('resession').load(require('util').get_git_branch())",
					},
					{ icon = " ", key = "f", desc = "Find File", action = ":FzfLua oldfiles" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					-- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},

				header = LOGO,
			},
			formats = {
				key = function(item)
					return { { "[ ", hl = "special" }, { item.key, hl = "key" }, { " ]", hl = "special" } }
				end,
			},
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				-- { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup", icon = "" },
			},
			debug = false,
		},
	},
	init = function()
		print = function(...)
			local print_safe_args = {}
			local args = { ... }
			for i = 1, #args do
				table.insert(print_safe_args, tostring(args[i]))
			end
			vim.notify(table.concat(print_safe_args, " "))
		end
	end,
}
