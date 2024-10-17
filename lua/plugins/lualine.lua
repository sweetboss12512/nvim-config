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
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					"filename",
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
				lualine_z = { { "progress", icon = "󰈚" } },
			},
		})
	end,
}
