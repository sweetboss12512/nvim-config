local icons = require("config.icons")

return {
	"nvim-lualine/lualine.nvim",
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				section_separators = { left = "", right = "" }, --
				component_separators = { left = " | ", right = " | " },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						-- icon = "" --[[ icon = "" ]],
						icon = "" --[[ icon = "" ]],
					},
				},
				lualine_b = { "branch", "diagnostics" },
				lualine_c = {
					-- "filename",
					{
						"buffers",
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							packer = "Packer",
							fzf = "FZF",
							alpha = "Alpha",
							["neo-tree"] = "Tree Explorer",
						},
					},
				},
				lualine_x = { --[[ "encoding",  ]]
					{ "fileformat" },
					{ "filetype" },
				},
				lualine_y = {
					-- {
					-- 	"datetime",
					-- 	-- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
					-- 	style = "%A",
					-- },
				},
				lualine_z = { { "progress", icon = icons.file } },
			},
			tabline = {
				lualine_a = { "tabs" },
				lualine_b = { "filename" },
				-- lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				-- lualine_z = { "tabs" },
			},
		})
	end,
}
