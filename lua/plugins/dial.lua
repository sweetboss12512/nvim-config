return {
	"monaqa/dial.nvim",
	-- enabled = false,
	keys = {
		{
			"<C-a>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			mode = { "n", "v" },
		},
		{
			"<C-x>",
			function()
				require("dial.map").manipulate("increment", "normal")
			end,
			mode = { "n", "v" },
		},
		{
			"g<C-a>",
			function()
				require("dial.map").manipulate("increment", "gnormal")
			end,
			mode = { "n", "v" },
		},
		{
			"g<C-x>",
			function()
				require("dial.map").manipulate("decrement", "gnormal")
			end,
			mode = { "n", "v" },
		},
	},
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			-- default augends used when no group name is specified
			default = {
				augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
				augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
				augend.constant.alias.bool,
				augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
				augend.semver.alias.semver,
			},
		})
	end,
}
