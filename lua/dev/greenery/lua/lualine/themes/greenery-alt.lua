local p = require("greenery.palette")
local config = require("greenery.config")

local bg_base = p.base
if config.options.styles.transparency then
	bg_base = "NONE"
end

return {
	normal = {
		a = { bg = p.surface, fg = p.rose, gui = "bold" },
		b = { bg = p.surface, fg = p.text },
		c = { bg = p.surface, fg = p.subtle, gui = "italic" },
	},
	insert = {
		a = { bg = p.surface, fg = p.foam, gui = "bold" },
	},
	visual = {
		a = { bg = p.surface, fg = p.iris, gui = "bold" },
	},
	replace = {
		a = { bg = p.surface, fg = p.pine, gui = "bold" },
	},
	command = {
		a = { bg = p.surface, fg = p.love, gui = "bold" },
	},
	inactive = {
		a = { bg = bg_base, fg = p.subtle, gui = "bold" },
		b = { bg = bg_base, fg = p.subtle },
		c = { bg = bg_base, fg = p.subtle, gui = "italic" },
	},
}
