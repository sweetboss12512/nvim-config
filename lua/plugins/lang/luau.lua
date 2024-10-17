local util = require("util")
local luau_lsp = require("luau-lsp")

local vscodeSettings = util.vscode_settings()

local directoryAliases
local fileAliases

if vscodeSettings then
	directoryAliases = vscodeSettings["luau-lsp.require.directoryAliases"] or luau_lsp.aliases()
	fileAliases = vscodeSettings["luau-lsp.require.fileAliases"]
end

return {
	"lopi-py/luau-lsp.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		luau_lsp.setup({
			filetypes = { "luau" },
			autostart = true,
			server = {
				settings = {
					["luau-lsp"] = {
						require = {
							mode = "relativeToFile",
							directoryAliases = directoryAliases,
							fileAliases = fileAliases,
							inlayHints = {
								functionReturnTypes = true,
								parameterTypes = true,
							},
						},
						completion = {
							autocompleteEnd = true,
							fillCallArguments = false,
							addParentheses = false,
							imports = {
								enabled = false,
							},
						},
					},
				},
			},
			platform = {
				type = "standard",
			},
			plugin = {
				enabled = false,
				port = 3667,
			},
			sourcemap = {
				enabled = false,
				autogenerate = false,
			},
			types = {
				-- roblox_security_level = "PluginSecurity",
			},
		})
	end,
}
